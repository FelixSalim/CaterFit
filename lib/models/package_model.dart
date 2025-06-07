import 'dart:io';

class Package {
  final int id;
  final String name;
  final String description;
  final String category;
  final List<String> mealPlans;
  final List<String> customizationTitles;
  final List<List<String>> customizationOptions;
  final File imageUrl;
  final double price;
  final int stock;

  Package({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.mealPlans,
    required this.customizationTitles,
    required this.customizationOptions,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: int.parse(json['id']),
      name: json['name'],
      description: json['description'],
      category: json['category'],
      mealPlans: List<String>.from(json['mealPlans']),
      customizationTitles: List<String>.from(json['customizationTitles']),
      customizationOptions: (json['customizationOptions'] as List)
          .map((e) => List<String>.from(e))
          .toList(),
      imageUrl: json['imageUrl'],
      price: double.parse(json['price']),
      stock: int.parse(json['stock']),
    );
  }
}
