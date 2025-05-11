import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/listing_provider.dart';
import '../providers/reservation_provider.dart';
import '../providers/expense_provider.dart';
import 'flight_listings_screen.dart';
import 'restaurant_listings_screen.dart';
import 'hotel_listings_screen.dart';
import 'car_listings_screen.dart';
import 'account_screen.dart';
import 'add_expense_screen.dart';
import 'add_travel_plan_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gelir Gider Takip'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Gelir/Gider'),
              Tab(text: 'Seyahat Planları'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExpensesTab(context),
            _buildTravelPlansTab(context),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final currentIndex = DefaultTabController.of(context).index;
            if (currentIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const AddExpenseScreen()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const AddTravelPlanScreen()),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildExpensesTab(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (ctx, expenseProvider, child) {
        final expenses = expenseProvider.expenses;
        if (expenses.isEmpty) {
          return const Center(
            child: Text('Henüz gelir/gider eklenmemiş'),
          );
        }
        return ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (ctx, index) {
            final expense = expenses[index];
            return ListTile(
              title: Text(expense.title),
              subtitle: Text(expense.category),
              trailing: Text(
                '${expense.isIncome ? '+' : '-'}${expense.amount.toStringAsFixed(2)} TL',
                style: TextStyle(
                  color: expense.isIncome ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                expense.isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                color: expense.isIncome ? Colors.green : Colors.red,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTravelPlansTab(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (ctx, expenseProvider, child) {
        final plans = expenseProvider.travelPlans;
        if (plans.isEmpty) {
          return const Center(
            child: Text('Henüz seyahat planı eklenmemiş'),
          );
        }
        return ListView.builder(
          itemCount: plans.length,
          itemBuilder: (ctx, index) {
            final plan = plans[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(plan.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hedef: ${plan.destination}'),
                    Text(
                      'Tarih: ${plan.startDate.toString().split(' ')[0]} - ${plan.endDate.toString().split(' ')[0]}',
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => expenseProvider.removeTravelPlan(plan.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
} 