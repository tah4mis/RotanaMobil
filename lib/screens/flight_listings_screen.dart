import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../providers/reservation_provider.dart';
import '../models/reservation.dart';

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
              child: Text('Henüz uçuş ilanı bulunmamaktadır.'),
            );
          }

          return ListView.builder(
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Image.asset(
                              flight.imageUrl,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                flight.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                flight.description,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${flight.price} TL',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Havayolu: ${flight.details['airline']}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Kalkış: ${flight.details['departureTime']}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Varış: ${flight.details['arrivalTime']}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Tarih: ${flight.details['date']}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _showReservationDialog(context, flight);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Rezervasyon Yap'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showReservationDialog(BuildContext context, flight) {
    final passengerController = TextEditingController();
    final passportController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rezervasyon Yap'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: passengerController,
              decoration: const InputDecoration(
                labelText: 'Yolcu Adı',
                hintText: 'Ad Soyad',
              ),
            ),
            TextField(
              controller: passportController,
              decoration: const InputDecoration(
                labelText: 'Pasaport/TC Kimlik No',
                hintText: 'XXXXXXXXXX',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  selectedDate = picked;
                }
              },
              child: const Text('Uçuş Tarihi Seç'),
            ),
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Seçilen Tarih: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              if (selectedDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Lütfen bir tarih seçin'),
                  ),
                );
                return;
              }

              final reservationProvider = Provider.of<ReservationProvider>(
                context,
                listen: false,
              );
              
              reservationProvider.addReservation(
                Reservation(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  type: 'flight',
                  title: flight.title,
                  date: selectedDate!,
                  status: 'Beklemede',
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