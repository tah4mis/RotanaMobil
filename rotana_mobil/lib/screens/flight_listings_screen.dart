import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../providers/reservation_provider.dart';

class FlightListingsScreen extends StatelessWidget {
  const FlightListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uçak Bileti İlanları'),
      ),
      body: Consumer<ListingProvider>(
        builder: (context, listingProvider, child) {
          final flights = listingProvider.getListingsByType('flight');
          
          if (flights.isEmpty) {
            return const Center(
              child: Text('Henüz uçak bileti ilanı bulunmamaktadır.'),
            );
          }

          return ListView.builder(
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(flight.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(flight.description),
                      Text('Fiyat: ${flight.price} TL'),
                      Text('Kalkış: ${flight.details['departureTime']}'),
                      Text('Varış: ${flight.details['arrivalTime']}'),
                      Text('Tarih: ${flight.details['date']}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _showReservationDialog(context, flight);
                    },
                    child: const Text('Rezervasyon Yap'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showReservationDialog(BuildContext context, flight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rezervasyon Onayı'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Uçuş: ${flight.title}'),
            Text('Fiyat: ${flight.price} TL'),
            const SizedBox(height: 16),
            const Text('Rezervasyon yapmak istediğinize emin misiniz?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              final reservationProvider = Provider.of<ReservationProvider>(
                context,
                listen: false,
              );
              
              reservationProvider.addReservation(
                Reservation(
                  id: DateTime.now().toString(),
                  type: 'flight',
                  title: flight.title,
                  date: DateTime.parse(flight.details['date']),
                  status: 'Onaylandı',
                ),
              );
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rezervasyonunuz başarıyla oluşturuldu.'),
                ),
              );
            },
            child: const Text('Onayla'),
          ),
        ],
      ),
    );
  }
} 