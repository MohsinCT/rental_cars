import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_cars/controller/car_controller.dart';

class SearchCars extends StatelessWidget {
  const SearchCars({super.key});

  @override
  Widget build(BuildContext context) {
    final CarController carController = Get.find(); // Get the controller

    return TextField(
      onChanged: (value) => carController.searchCars(value),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: "Search by car name or company",
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
