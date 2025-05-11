import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;

  Future<void> login(String email, String password) async {
    // Burada gerçek bir API çağrısı yapılacak
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _isLoggedIn = false;
    _userName = '';
    _userEmail = '';
    _userPhone = '';
    notifyListeners();
  }

  Future<void> updateProfile(String name, String phone) async {
    _userName = name;
    _userPhone = phone;
    notifyListeners();
  }
} 