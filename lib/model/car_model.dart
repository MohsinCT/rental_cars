class CarModel {
  final String id;
  final String carname;
  final String company;
  final int maxPower;
  final int fuel;
  final int mph;
  final int maxSpeed;
  final int price;
  final String color;
  final String model;
  final String wheelType;
  final String fuelType;
  final String year;
  
  final String? carImage1;
  final String? carImage2;
  final String? carImage3;
  final String? carImage4;

  CarModel({
    required this.id,
    required this.carname,
    required this.company,
    required this.maxPower,
    required this.fuel,
    required this.mph,
    required this.maxSpeed,
    required this.price,
    required this.color,
    required this.model,
    required this.wheelType,
    required this.fuelType,
    required this.year,
    this.carImage1,
    this.carImage2,
    this.carImage3,
    this.carImage4,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'carname': carname,
    'company': company,
    'maxPower': maxPower,
    'fuel': fuel,
    'mph': mph,
    'maxSpeed': maxSpeed,
    'price': price,
    'color': color,
    'model': model,
    'wheelType': wheelType,
    'fuelType': fuelType,
    'year': year,
    'carImage1': carImage1,
    'carImage2': carImage2,
    'carImage3': carImage3,
    'carImage4': carImage4,
  };

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    id: json['id'],
    carname: json['carname'],
    company: json['company'],
    maxPower: json['maxPower'],
    fuel: json['fuel'],
    mph: json['mph'],
    maxSpeed: json['maxSpeed'],
    price: json['price'],
    color: json['color'],
    model: json['model'],
    wheelType: json['wheelType'],
    fuelType: json['fuelType'],
    year: json['year'],
    carImage1: json['carImage1'],
    carImage2: json['carImage2'],
    carImage3: json['carImage3'],
    carImage4: json['carImage4'],
  );
}
