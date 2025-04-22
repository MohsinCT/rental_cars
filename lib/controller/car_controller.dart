import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_cars/model/car_model.dart';


class CarController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CarModel> cars = <CarModel>[].obs;
  RxList<CarModel> filteredCars = <CarModel>[].obs;

  @override
  void onInit(){
    fetchCars();
  super.onInit();

  }

  Future<void> addCar(CarModel car) async {
    try{
       await _firestore.collection('cars').doc(car.id).set(car.toJson());
    fetchCars();
      log('car details added');
    }catch (e){
      log('error adding car details $e');

    }
    // optional
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
}
