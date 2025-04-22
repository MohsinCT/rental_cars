import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_cars/controller/car_controller.dart';
import 'package:rental_cars/model/car_model.dart';


class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();

  final carNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final maxPowerController = TextEditingController();
  final fuelController = TextEditingController();
  final fuelTypeController = TextEditingController();
  final zeroToSixtyController = TextEditingController();
  final maxSpeedController = TextEditingController();
  final priceController = TextEditingController();
  final colorController = TextEditingController();
  final modelController = TextEditingController();
  final wheelTypeController = TextEditingController();
  final manufacturingYearController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  List<XFile?> carImages = List<XFile?>.filled(4, null);

  final CarController carController = Get.put(CarController());

  Future<void> pickImage(int index) async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        carImages[index] = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = SizedBox(height: 15);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Car'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Upload 4 Car Images (optional)", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => pickImage(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: carImages[index] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(carImages[index]!.path),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(child: Icon(Icons.add_a_photo, size: 40)),
                    ),
                  );
                },
              ),
              spacing,
              buildTextField("Car Name", carNameController),
              spacing,
              buildTextField("Company Name", companyNameController),
              spacing,
              buildTextField("Max Power (HP)", maxPowerController, isNumber: true),
              spacing,
              buildTextField("Fuel (Litres)", fuelController, isNumber: true),
              spacing,
              buildTextField("Fuel Type", fuelTypeController),
              spacing,
              buildTextField("0-60mph (sec)", zeroToSixtyController, isNumber: true),
              spacing,
              buildTextField("Max Speed (mph)", maxSpeedController, isNumber: true),
              spacing,
              buildTextField("Price", priceController, isNumber: true),
              spacing,
              buildTextField("Color", colorController),
              spacing,
              buildTextField("Model", modelController),
              spacing,
              buildTextField("Wheel Type", wheelTypeController),
              spacing,
              buildTextField("Manufacturing Year", manufacturingYearController, isNumber: true),
              spacing,
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final car = CarModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      carname: carNameController.text.trim(),
                      company: companyNameController.text.trim(),
                      maxPower: int.parse(maxPowerController.text.trim()),
                      fuel: int.parse(fuelController.text.trim()),
                      mph: int.parse(zeroToSixtyController.text.trim()),
                      maxSpeed: int.parse(maxSpeedController.text.trim()),
                      price: int.parse(priceController.text.trim()),
                      color: colorController.text.trim(),
                      model: modelController.text.trim(),
                      wheelType: wheelTypeController.text.trim(),
                      fuelType: fuelTypeController.text.trim(),
                      year: manufacturingYearController.text.trim(),
                    );

                    await carController.addCar(car);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Car Added Successfully")),
                    );

                    _formKey.currentState!.reset();
                    carImages = List<XFile?>.filled(4, null);
                    setState(() {});
                  }
                },
                child: const Text("Add Car"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}
    