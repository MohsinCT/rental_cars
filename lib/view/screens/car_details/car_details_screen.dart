import 'package:flutter/material.dart';
import 'package:rental_cars/model/car_model.dart';
import 'package:rental_cars/view/screens/car_details/car_images.dart';
import 'package:rental_cars/view/screens/car_details/car_specifications.dart';
import 'package:rental_cars/view/screens/car_details/car_title.dart';

class CarDetails extends StatelessWidget {
  final CarModel car;
  const CarDetails({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Name
              CarTitle(car: car),

              SizedBox(height: mediaQuery.size.height * 0.02),

              // Car Images
              CarImages(car: car),

              SizedBox(height: mediaQuery.size.height * 0.04),

              // Car Specifications
              CarSpecifications(car: car),
            ],
          ),
        ),
      ),
    );
  }
}
