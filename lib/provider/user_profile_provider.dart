// user_profile_provider.dart
import 'dart:convert';
import 'package:e_com_app/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserProfileProvider with ChangeNotifier {
  UserProfileModel? _userProfile;
  bool _isLoading = false;
  String _errorMessage = '';

  UserProfileModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch user profile from the API
  Future<void> fetchUserProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/users/1'));

      if (response.statusCode == 200) {
        // Parse the response JSON and convert it into the UserProfileModel
        _userProfile = UserProfileModel.fromJson(jsonDecode(response.body));
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to load user profile';
      }
    } catch (error) {
      _errorMessage = 'Failed to load user profile: $error';
    }

    _isLoading = false;
    notifyListeners();
  }
}
