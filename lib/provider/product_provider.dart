import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _products = await _productService.fetchProducts();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchProductsForCategory(String selectedCategory) {}
}
