import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rental_cars/model/car_model.dart';

class CarImages extends StatelessWidget {
  final CarModel car;
  const CarImages({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);


    final List<String> carImages = [
      if (car.carImage1 != null && car.carImage1!.isNotEmpty) car.carImage1!,
      if (car.carImage2 != null && car.carImage2!.isNotEmpty) car.carImage2!,
      if (car.carImage3 != null && car.carImage3!.isNotEmpty) car.carImage3!,
      if (car.carImage4 != null && car.carImage4!.isNotEmpty) car.carImage4!,
    ];
    return carImages.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: mediaQuery.size.height * 0.28,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: carImages.map((imageUrl) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            imageUrl,
                            width: mediaQuery.size.width,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    )
                  : const Center(child: Text('No Images Available'))
    ;
  }
}