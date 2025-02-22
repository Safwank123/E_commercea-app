import 'package:flutter/material.dart';

class ProductModel {
  int id;
  String title;
  double price;
  String description;
  Category category;
  String image;
  Rating rating;
  int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity = 1, // Default to 1 if not provided
  });

  // Implement the fromJson method to parse JSON correctly
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price']?.toDouble() ?? 0.0),
      description: json['description'] ?? '',
      category: ProductModel._parseCategory(json['category'] ?? 'electronics'), // Use ProductModel._parseCategory
      image: json['image'] ?? '',
      rating: json['rating'] != null
          ? Rating.fromJson(json['rating'])
          : Rating(rate: 0.0, count: 0),
      quantity: json['quantity'] ?? 1,
    );
  }

  // Convert to JSON (including quantity)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': ProductModel._categoryToString(category), // Use ProductModel._categoryToString
      'image': image,
      'rating': rating.toJson(),
      'quantity': quantity,
    };
  }

  // Static method to parse category from string
  static Category _parseCategory(String categoryStr) {
    switch (categoryStr.toLowerCase()) { // Convert to lower case to make it case-insensitive
      case 'electronics':
        return Category.ELECTRONICS;
      case 'jewelery':
        return Category.JEWELERY;
      case 'men\'s clothing':
        return Category.MEN_S_CLOTHING;
      case 'women\'s clothing':
        return Category.WOMEN_S_CLOTHING;
      default:
        return Category.ELECTRONICS; // Default category if invalid category
    }
  }

  // Static method to convert category enum to string
  static String _categoryToString(Category category) {
    switch (category) {
      case Category.ELECTRONICS:
        return 'electronics';
      case Category.JEWELERY:
        return 'jewelery';
      case Category.MEN_S_CLOTHING:
        return 'men\'s clothing';
      case Category.WOMEN_S_CLOTHING:
        return 'women\'s clothing';
      default:
        return 'electronics';
    }
  }
}

enum Category {
  ELECTRONICS,
  JEWELERY,
  MEN_S_CLOTHING,
  WOMEN_S_CLOTHING
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  // Factory method to create Rating from JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate']?.toDouble() ?? 0.0, // Default to 0.0 if rate is missing or invalid
      count: json['count'] ?? 0, // Default to 0 if count is missing
    );
  }

  // Convert Rating to JSON
  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
