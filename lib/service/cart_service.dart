import 'dart:convert';
import 'package:http/http.dart' as http;

class FakeStoreService {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Fetch all products
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch product details by ID
  Future<Map<String, dynamic>> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
