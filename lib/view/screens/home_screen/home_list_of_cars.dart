import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_cars/controller/car_controller.dart';
import 'package:rental_cars/view/screens/home_screen/home_car_card.dart';

class CarListView extends StatelessWidget {
  const CarListView({super.key});

  @override
  Widget build(BuildContext context) {
    final carController = Get.find<CarController>();

    return Obx(() {
      if (carController.isLoading.value) {
        return const Center(child: CupertinoActivityIndicator());
      } else if(carController.filteredCars.isEmpty){
        return const  Center(child: Text('No cars have added',style: TextStyle(
          color: Colors.grey
        ),),);
      }

      return ListView.builder(
        itemCount: carController.filteredCars.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final car = carController.filteredCars[index];
          return CarCard(car: car);
        },
      );
    });
  }
}
