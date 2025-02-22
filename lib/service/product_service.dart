import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  final String _baseUrl = 'https://fakestoreapi.com/products';

  // Change the return type to Future<List<ProductModel>>
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        // Decode the response body into a List<dynamic>
        List<dynamic> data = jsonDecode(response.body);

        // Explicitly cast the mapped data to List<ProductModel>
        return data.map((json) => ProductModel.fromJson(json)).toList().cast<ProductModel>();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
