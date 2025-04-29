import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_cars/model/car_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CarController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CarModel> cars = <CarModel>[].obs;
  RxList<CarModel> filteredCars = <CarModel>[].obs;

  // New variables for multiple image uploading
  RxList<File> pickedImages = <File>[].obs;
  RxList<String> uploadedImageUrls = <String>[].obs;
  
  RxBool isUploading = false.obs;

  final cloudName = 'dmihepkfq';       
  final uploadPreset = 'carImages';  

  @override
  void onInit() {
    fetchCars();
    super.onInit();
  }

  Future<void> addCar(CarModel car) async {
    try {
      await _firestore.collection('cars').doc(car.id).set(car.toJson());
      fetchCars();
      log('Car details added');
    } catch (e) {
      log('Error adding car details: $e');
    }
  }

  Future<void> deleteCar(String carId) async {
  try {
    await _firestore.collection('cars').doc(carId).delete();

    // Optionally remove it from local list
    cars.removeWhere((car) => car.id == carId);
    filteredCars.removeWhere((car) => car.id == carId);

    log('Car with ID $carId deleted successfully');
  } catch (e) {
    log('Error deleting car: $e');
  }
}


  Future<void> fetchCars() async {
    final snapshot = await _firestore.collection('cars').get();
    cars.value = snapshot.docs.map((doc) => CarModel.fromJson(doc.data())).toList();
    filteredCars.assignAll(cars);
  }

  void searchCars(String query) {
    if (query.isEmpty) {
      filteredCars.assignAll(cars);
    } else {
      final lowerQuery = query.toLowerCase();
      final results = cars.where((car) =>
          car.carname.toLowerCase().contains(lowerQuery) ||
          car.company.toLowerCase().contains(lowerQuery) ||
          car.model.toLowerCase().contains(lowerQuery)
      ).toList();

      filteredCars.assignAll(results);
    }
  }


  //  Pick multiple images from the camera (up to 4)
  // Modified pickImages method to use the camera instead of gallery
Future<void> pickImages() async {
  final ImagePicker picker = ImagePicker();

  // Check if the pickedImages list already has 4 images
  if (pickedImages.length >= 4) {
    log('Maximum of 4 images can be selected');
    return;  // Prevent adding more images
  }

  // Picking an image using the camera
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  // If an image is picked and there is space in the list, add it
  if (image != null && pickedImages.length < 4) {
    pickedImages.add(File(image.path));  // Add to the list
    log('Image added: ${image.path}');
  }
}



  //  Upload single image to Cloudinary
  Future<String> uploadSingleImage(File imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStream = await response.stream.bytesToString();
      final resData = json.decode(resStream);
      return resData['secure_url'];
    } else {
      throw Exception('Image upload failed with status: ${response.statusCode}');
    }
  }

  //  Upload all picked images
  Future<void> uploadAllImages() async {
    if (pickedImages.isEmpty) return;

    isUploading.value = true;
    uploadedImageUrls.clear();

    try {
      List<Future<String>> uploadTasks = pickedImages.map((img) => uploadSingleImage(img)).toList();
      List<String> urls = await Future.wait(uploadTasks);
      uploadedImageUrls.assignAll(urls);
      log('All images uploaded: $uploadedImageUrls');
    } catch (e) {
      log('Error uploading images: $e');
    }

    isUploading.value = false;
  }

  //  Add Car with uploaded images
  Future<void> addCarWithImages(CarModel car) async {
    try {
      await uploadAllImages();

      final newCar = CarModel(
        id: car.id,
        carname: car.carname,
        company: car.company,
        maxPower: car.maxPower,
        fuel: car.fuel,
        mph: car.mph,
        maxSpeed: car.maxSpeed,
        price: car.price,
        color: car.color,
        model: car.model,
        wheelType: car.wheelType,
        fuelType: car.fuelType,
        year: car.year,
        carImage1: uploadedImageUrls.isNotEmpty ? uploadedImageUrls[0] : null,
        carImage2: uploadedImageUrls.length > 1 ? uploadedImageUrls[1] : null,
        carImage3: uploadedImageUrls.length > 2 ? uploadedImageUrls[2] : null,
        carImage4: uploadedImageUrls.length > 3 ? uploadedImageUrls[3] : null,
      );

      await addCar(newCar);

      log('Car added successfully with images');
    } catch (e) {
      log('Error adding car with images: $e');
    }
  }
  // reset image

  void resetImages() {
  pickedImages.clear();
  uploadedImageUrls.clear();
  isUploading.value = false;
  log('Image selection and upload state reset');
}

}
