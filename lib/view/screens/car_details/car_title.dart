import 'package:flutter/material.dart';
import 'package:rental_cars/model/car_model.dart';

class CarTitle extends StatelessWidget {
  final CarModel car;
  const CarTitle({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
                car.carname,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Company Name
              Text(
                car.company,
                style: textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
      ],
    );
  }
}
