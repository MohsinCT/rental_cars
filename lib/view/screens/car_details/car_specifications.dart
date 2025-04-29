import 'package:flutter/material.dart';
import 'package:rental_cars/model/car_model.dart';

class CarSpecifications extends StatelessWidget {
  final CarModel car;
  const CarSpecifications({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specifications',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _specCard(
                fontsize: mediaQuery.size.width * 0.025,
                icon: Icons.battery_charging_full_outlined,
                title: 'Max Power',
                value: '${car.maxPower} hp',
                context: context,
                width: mediaQuery.size.width * 0.22,
              ),
              _specCard(
                fontsize: mediaQuery.size.width * 0.025,
                icon: Icons.local_gas_station,
                title: 'Fuel',
                value: '${car.fuel} km',
                context: context,
                width: mediaQuery.size.width * 0.23,
              ),
              _specCard(
                fontsize: mediaQuery.size.width * 0.025,
                icon: Icons.flash_on,
                title: '0-60 mph',
                value: '${car.mph} sec',
                context: context,
                width: mediaQuery.size.width * 0.22,
              ),
              _specCard(
                fontsize: mediaQuery.size.width * 0.025,
                icon: Icons.speed,
                title: 'Max Speed',
                value: '${car.maxSpeed} mph',
                context: context,
                width: mediaQuery.size.width * 0.22,
              ),
            ],
          ),
        ),

        SizedBox(height: mediaQuery.size.height * 0.03),

        _vehicleDetailRow('Color', car.color),
        _vehicleDetailRow('Model', car.model),
        _vehicleDetailRow('Wheel Type', car.wheelType),
        _vehicleDetailRow('Fuel Type', car.fuelType),
        _vehicleDetailRow('Manufacturing Year', car.year),
      ],
    );
  }

  Widget _specCard({
    required IconData icon,
    required String title,
    required String value,
    required BuildContext context,
    required double width,
    double? fontsize,
    double? height,
  }) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey, size: 24),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: fontsize, color: Colors.black54),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _vehicleDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
