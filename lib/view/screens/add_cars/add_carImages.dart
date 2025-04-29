import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_cars/controller/car_controller.dart';

class AddCarImages extends StatelessWidget {
  const AddCarImages({super.key});

  @override
  Widget build(BuildContext context) {
    final carController = Get.find<CarController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload 4 Car Images",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () => carController.pickImages(),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: carController.pickedImages.length > index
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            carController.pickedImages[index],
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.add_a_photo, size: 40),
                        ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
