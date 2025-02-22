import 'dart:convert';

import 'package:e_com_app/models/single_product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class SingleProductProvider with ChangeNotifier {
  SingleProductModel? _product;
  bool _isLoading = false;

  SingleProductModel? get product => _product;
  bool get isLoading => _isLoading;

  Future<void> fetchProductById(String productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Replace with your actual API call
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _product = SingleProductModel.fromJson(data);
      } else {
        _product = null;
      }
    } catch (e) {
      print("Error fetching product: $e");
      _product = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
