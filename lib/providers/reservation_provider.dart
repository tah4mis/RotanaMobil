import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reservation.dart';

class ReservationProvider with ChangeNotifier {
  List<Reservation> _reservations = [];
  
  List<Reservation> get reservations => _reservations;

  ReservationProvider() {
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    final prefs = await SharedPreferences.getInstance();
    final String? reservationsJson = prefs.getString('reservations');
    if (reservationsJson != null) {
      try {
        final List<dynamic> decodedList = json.decode(reservationsJson);
        _reservations = decodedList.map((item) => Reservation.fromJson(item)).toList();
        notifyListeners();
      } catch (e) {
        print('Rezervasyon yükleme hatası: $e');
        _reservations = [];
      }
    }
  }

  Future<void> _saveReservations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedList = json.encode(
        _reservations.map((reservation) => reservation.toJson()).toList(),
      );
      await prefs.setString('reservations', encodedList);
    } catch (e) {
      print('Rezervasyon kaydetme hatası: $e');
    }
  }

  Future<void> addReservation(Reservation reservation) async {
    _reservations.add(reservation);
    await _saveReservations();
    notifyListeners();
  }

  Future<void> removeReservation(String id) async {
    _reservations.removeWhere((reservation) => reservation.id == id);
    await _saveReservations();
    notifyListeners();
  }

  Future<void> updateReservationStatus(String id, String status) async {
    final index = _reservations.indexWhere((reservation) => reservation.id == id);
    if (index != -1) {
      _reservations[index] = _reservations[index].copyWith(status: status);
      await _saveReservations();
      notifyListeners();
    }
  }

  List<Reservation> getReservationsByType(String type) {
    return _reservations.where((reservation) => reservation.type == type).toList();
  }
} 