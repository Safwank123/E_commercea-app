import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Please fill in all fields');
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Handle successful login (e.g., store token)
        print('Login Successful: ${data['token']}');
      } else {
        throw Exception('Login Failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
