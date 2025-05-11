import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isIncome;
  final String category;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.category,
  }) : id = id ?? const Uuid().v4();
}

class TravelPlan {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String notes;
  final List<String> activities;

  TravelPlan({
    String? id,
    required this.title,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.notes,
    required this.activities,
  }) : id = id ?? const Uuid().v4();
} 