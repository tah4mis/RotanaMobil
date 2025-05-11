import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';
  bool _isLoggedIn = false;

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    // TODO: Implement actual login logic
    _userName = 'Test User';
    _userEmail = email;
    _userPhone = '+90 555 555 5555';
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    _userName = '';
    _userEmail = '';
    _userPhone = '';
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> updateProfile(String name, String phone) async {
    _userName = name;
    _userPhone = phone;
    notifyListeners();
  }
} 