import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rental_cars/model/car_model.dart';

class CarDetails extends StatelessWidget {
  final CarModel car;
  const CarDetails({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textTheme = Theme.of(context).textTheme;

    final List<String> carImages = [
      'https://cdn.pixabay.com/photo/2015/01/19/13/51/car-604019_1280.jpg',
      'https://cdn.pixabay.com/photo/2017/03/27/14/56/ferrari-2179220_1280.jpg',
      'https://cdn.pixabay.com/photo/2017/01/06/19/15/auto-1957037_1280.jpg',
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Name
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

              const SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: mediaQuery.size.height * 0.28,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items:
                    carImages.map((imageUrl) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          imageUrl,
                          width: mediaQuery.size.width,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
              ),

              const SizedBox(height: 30),

              // Specifications Title
              Text(
                'Specifications',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Specification Cards in a Single Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: // Specification Cards in a Single Row
                    Row(
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
          ),
        ),
      ),
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
            // ignore: deprecated_member_use
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
          SizedBox(height: 20),
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
