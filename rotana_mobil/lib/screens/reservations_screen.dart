import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezervasyonlarım'),
      ),
      body: Consumer<ReservationProvider>(
        builder: (context, reservationProvider, child) {
          final reservations = reservationProvider.reservations;
          
          if (reservations.isEmpty) {
            return const Center(
              child: Text('Henüz rezervasyonunuz bulunmamaktadır.'),
            );
          }

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: _getIconForType(reservation.type),
                  title: Text(reservation.title),
                  subtitle: Text(
                    'Tarih: ${reservation.date.day}/${reservation.date.month}/${reservation.date.year}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      reservationProvider.removeReservation(reservation.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Icon _getIconForType(String type) {
    switch (type) {
      case 'flight':
        return const Icon(Icons.flight, color: Colors.blue);
      case 'restaurant':
        return const Icon(Icons.restaurant, color: Colors.green);
      case 'hotel':
        return const Icon(Icons.hotel, color: Colors.orange);
      case 'car':
        return const Icon(Icons.directions_car, color: Colors.purple);
      default:
        return const Icon(Icons.help, color: Colors.grey);
    }
  }
} 