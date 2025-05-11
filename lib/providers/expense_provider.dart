import 'package:flutter/foundation.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];
  final List<TravelPlan> _travelPlans = [];

  List<Expense> get expenses => [..._expenses];
  List<TravelPlan> get travelPlans => [..._travelPlans];

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void addTravelPlan(TravelPlan plan) {
    _travelPlans.add(plan);
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  void removeTravelPlan(String id) {
    _travelPlans.removeWhere((plan) => plan.id == id);
    notifyListeners();
  }
} 