import 'package:flutter/material.dart';

class AddSpecifications extends StatelessWidget {
  final TextEditingController carNameController;
  final TextEditingController companyNameController;
  final TextEditingController maxPowerController;
  final TextEditingController fuelController;
  final TextEditingController fuelTypeController;
  final TextEditingController zeroToSixtyController;
  final TextEditingController maxSpeedController;
  final TextEditingController priceController;
  final TextEditingController colorController;
  final TextEditingController modelController;
  final TextEditingController wheelTypeController;
  final TextEditingController manufacturingYearController;

  const AddSpecifications({
    super.key,
    required this.carNameController,
    required this.companyNameController,
    required this.maxPowerController,
    required this.fuelController,
    required this.fuelTypeController,
    required this.zeroToSixtyController,
    required this.maxSpeedController,
    required this.priceController,
    required this.colorController,
    required this.modelController,
    required this.wheelTypeController,
    required this.manufacturingYearController, required GlobalKey<FormState> formKey,
  });

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(height: 15);

    return Column(
      children: [
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
      ],
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
