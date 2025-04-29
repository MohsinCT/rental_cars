import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_cars/constants/colors.dart';
import 'package:rental_cars/controller/car_controller.dart';
import 'package:rental_cars/view/screens/home_screen/home_appbar.dart';
import 'package:rental_cars/view/screens/home_screen/home_header.dart';
import 'package:rental_cars/view/screens/home_screen/home_list_of_cars.dart';
import 'package:rental_cars/view/screens/home_screen/home_search_cars.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CarController carController = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.rGrey,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              HomeHeader(),
              SizedBox(height: mediaQuery.size.height * 0.02),
              // Search Cars
              SearchCars(),
              SizedBox(height: mediaQuery.size.height * 0.02),
              // ListofCars
              CarListView(),
            ],
          ),
        ),
      ),
    );
  }
}
