import 'dart:convert';
import 'package:e_com_app/models/single_product_model.dart';
import 'package:http/http.dart' as http;


class SingleProductService {
  final String apiUrl = "https://fakestoreapi.com/products/1";

  Future<SingleProductModel> fetchProduct() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SingleProductModel.fromJson(data);
    } else {
      throw Exception("Failed to load product");
    }
  }
}
