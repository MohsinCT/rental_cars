import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_cars/constants/colors.dart';
import 'package:rental_cars/controller/car_controller.dart';
import 'package:rental_cars/model/car_model.dart';

import 'package:rental_cars/view/add_cars_screen.dart';
import 'package:rental_cars/view/car_details_screen.dart';
import 'package:rental_cars/view/widgets/custom_search_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CarController carController = Get.put(CarController());

  final List<String> featuredImages = const [
    'https://cdn.pixabay.com/photo/2015/01/19/13/51/car-604019_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/03/27/14/56/ferrari-2179220_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/22/20/09/auto-1851246_1280.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.rGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '🚗 Rentals',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const AddCarScreen()),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                "Find Your Dream Car",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Explore our best collection of rental cars",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Search Field
              const SearchCars(),
              const SizedBox(height: 20),

              // Car List using GetX
              Obx(() {
                if (carController.filteredCars.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: carController.filteredCars.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final CarModel car = carController.filteredCars[index];

                    return GestureDetector(
                      onTap:
                          () => Get.to(
                            () =>  CarDetails(car:car,),
                          ), // You can pass car if needed
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              // Car Image (Placeholder image here for now)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2015/01/19/13/51/car-604019_1280.jpg',
                                  width: mediaQuery.size.width * 0.3,
                                  height: mediaQuery.size.height * 0.12,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),

                              // Car Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      car.carname,
                                      style: TextStyle(
                                        fontSize: mediaQuery.size.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      car.company,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(car.year),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          size: 18,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          '${car.price} / Day',
                                          style: TextStyle(color: Colors.green),
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
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
