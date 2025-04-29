import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_cars/controller/car_controller.dart';
import 'package:rental_cars/model/car_model.dart';
import 'package:rental_cars/view/screens/car_details/car_details_screen.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  const CarCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {

    final CarController carController = Get.put(CarController());
    final mediaQuery = MediaQuery.of(context);

    return GestureDetector(
      onTap: () => Get.to(() => CarDetails(car: car)),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _getFirstAvailableImage(car),
                  width: mediaQuery.size.width * 0.3,
                  height: mediaQuery.size.height * 0.12,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          car.carname,
                          style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () async {

                            await carController.deleteCar(car.id);
                            

                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),
                    Text(
                      car.company,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14),
                        const SizedBox(width: 4),
                        Text(car.year),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.currency_rupee,
                          size: 18,
                          color: Colors.green,
                        ),
                        Text(
                          '${car.price} / Day',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFirstAvailableImage(CarModel car) {
    if (car.carImage1 != null && car.carImage1!.isNotEmpty) {
      return car.carImage1!;
    } else if (car.carImage2 != null && car.carImage2!.isNotEmpty) {
      return car.carImage2!;
    } else if (car.carImage3 != null && car.carImage3!.isNotEmpty) {
      return car.carImage3!;
    } else if (car.carImage4 != null && car.carImage4!.isNotEmpty) {
      return car.carImage4!;
    } else {
      return 'https://via.placeholder.com/150';
    }
  }
}
