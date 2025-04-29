import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_cars/controller/car_controller.dart';
import 'package:rental_cars/model/car_model.dart';
import 'package:rental_cars/view/screens/add_cars/add_carImages.dart';
import 'package:rental_cars/view/screens/add_cars/add_specifications.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();

  final carNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final maxPowerController = TextEditingController();
  final fuelController = TextEditingController();
  final fuelTypeController = TextEditingController();
  final zeroToSixtyController = TextEditingController();
  final maxSpeedController = TextEditingController();
  final priceController = TextEditingController();
  final colorController = TextEditingController();
  final modelController = TextEditingController();
  final wheelTypeController = TextEditingController();
  final manufacturingYearController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  List<XFile?> carImages = List<XFile?>.filled(4, null); // to hold images

  final CarController carController = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    final spacing = SizedBox(height: 15);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            carController.resetImages();
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Add new car'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AddCarImages(),

              spacing,
              AddSpecifications(
                carNameController: carNameController,
                companyNameController: companyNameController,
                maxPowerController: maxPowerController,
                fuelController: fuelController,
                fuelTypeController: fuelTypeController,
                zeroToSixtyController: zeroToSixtyController,
                maxSpeedController: maxSpeedController,
                priceController: priceController,
                colorController: colorController,
                modelController: modelController,
                wheelTypeController: wheelTypeController,
                manufacturingYearController: manufacturingYearController,
                formKey: _formKey,
              ),
              spacing,
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Upload images before adding the car
                    await carController.uploadAllImages();

                    // Get the URLs of uploaded images
                    final uploadedImageUrls = carController.uploadedImageUrls;

                    final car = CarModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      carname: carNameController.text.trim(),
                      company: companyNameController.text.trim(),
                      maxPower: int.parse(maxPowerController.text.trim()),
                      fuel: int.parse(fuelController.text.trim()),
                      mph: int.parse(zeroToSixtyController.text.trim()),
                      maxSpeed: int.parse(maxSpeedController.text.trim()),
                      price: int.parse(priceController.text.trim()),
                      color: colorController.text.trim(),
                      model: modelController.text.trim(),
                      wheelType: wheelTypeController.text.trim(),
                      fuelType: fuelTypeController.text.trim(),
                      year: manufacturingYearController.text.trim(),
                      // Add URLs of uploaded images
                      carImage1:
                          uploadedImageUrls.isNotEmpty
                              ? uploadedImageUrls[0]
                              : null,
                      carImage2:
                          uploadedImageUrls.length > 1
                              ? uploadedImageUrls[1]
                              : null,
                      carImage3:
                          uploadedImageUrls.length > 2
                              ? uploadedImageUrls[2]
                              : null,
                      carImage4:
                          uploadedImageUrls.length > 3
                              ? uploadedImageUrls[3]
                              : null,
                    );

                    await carController.addCarWithImages(
                      car,
                    ); // Add car with images

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Car Added Successfully")),
                    );

                    // Reset form and image selections
                    _formKey.currentState!.reset();
                    carController.resetImages();
                    // carImages = List<XFile?>.filled(4, null);
                  }
                },
                child: const Text("Add Car"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
