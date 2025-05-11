import 'package:flutter/material.dart';

class Reservation {
  final String id;
  final String type; // 'flight', 'restaurant', 'hotel', 'car'
  final String title;
  final DateTime date;
  final String status;

  Reservation({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.status,
  });
}

class ReservationProvider with ChangeNotifier {
  final List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  void addReservation(Reservation reservation) {
    _reservations.add(reservation);
    notifyListeners();
  }

  void removeReservation(String id) {
    _reservations.removeWhere((reservation) => reservation.id == id);
    notifyListeners();
  }

  List<Reservation> getReservationsByType(String type) {
    return _reservations.where((reservation) => reservation.type == type).toList();
  }
} 