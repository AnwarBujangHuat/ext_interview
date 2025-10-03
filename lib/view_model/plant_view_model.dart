import 'package:flutter/material.dart';

class Service {
  final String title;
  final String description;
  final String imagePath;
  final double price;

  Service({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
  });
}

class Plant {
  final String name;
  final String description;
  final String imagePath;
  final double price;

  Plant({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  });
}

class PlantSectionViewModel extends ChangeNotifier {
  List<Service> services = [
    Service(
      title: 'Premium Plant Care Package',
      description: 'Complete care for your indoor plants',
      imagePath: 'assets/Image.jpg',
      price: 85.0,
    ),
    Service(
      title: 'Garden Design Consultation',
      description: 'Expert advice for your garden layout',
      imagePath: 'assets/Image.jpg',
      price: 120.0,
    ),
    Service(
      title: 'Plant Delivery Service',
      description: 'Fast and safe delivery of your plants',
      imagePath: 'assets/Image.jpg',
      price: 30.0,
    ),
    Service(
      title: 'Soil & Fertilizer Supply',
      description: 'High-quality soil and fertilizer for healthy plants',
      imagePath: 'assets/Image.jpg',
      price: 25.0,
    ),
    Service(
      title: 'Pest Control Treatment',
      description: 'Protect your plants from common pests',
      imagePath: 'assets/Image.jpg',
      price: 50.0,
    ),
    // Add more services as needed...
  ];

  List<Plant> trendingPlants = [
    Plant(
      name: 'Monstera Deliciosa Premium',
      description: 'Perfect for indoor decoration with beautiful split leaves',
      imagePath: 'assets/Image.jpg',
      price: 45.0,
    ),
    // Add more plants...
  ];
}