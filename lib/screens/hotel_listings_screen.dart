import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../providers/reservation_provider.dart';
import '../models/reservation.dart';

class HotelListingsScreen extends StatelessWidget {
  const HotelListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Otel İlanları'),
      ),
      body: Consumer<ListingProvider>(
        builder: (context, listingProvider, child) {
          final hotels = listingProvider.getListingsByType('hotel');
          
          if (hotels.isEmpty) {
            return const Center(
              child: Text('Henüz otel ilanı bulunmamaktadır.'),
            );
          }

          return ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      child: Image.network(
                        hotel.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.hotel,
                              size: 64,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  hotel.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color: index < int.parse(hotel.details['stars'].toString())
                                        ? Colors.amber
                                        : Colors.grey[300],
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            hotel.description,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${hotel.price} TL / gece',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Konum: ${hotel.details['location']}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Özellikler: ${(hotel.details['amenities'] as List).join(', ')}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _showReservationDialog(context, hotel);
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

  void _showReservationDialog(BuildContext context, hotel) {
    final guestsController = TextEditingController();
    DateTime? checkInDate;
    DateTime? checkOutDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rezervasyon Yap'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  checkInDate = picked;
                }
              },
              child: const Text('Giriş Tarihi Seç'),
            ),
            if (checkInDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Giriş: ${checkInDate!.day}/${checkInDate!.month}/${checkInDate!.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: checkInDate ?? DateTime.now(),
                  firstDate: checkInDate ?? DateTime.now(),
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
                  checkOutDate = picked;
                }
              },
              child: const Text('Çıkış Tarihi Seç'),
            ),
            if (checkOutDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Çıkış: ${checkOutDate!.day}/${checkOutDate!.month}/${checkOutDate!.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: guestsController,
              decoration: const InputDecoration(
                labelText: 'Kişi Sayısı',
                hintText: '2',
              ),
              keyboardType: TextInputType.number,
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
              if (checkInDate == null || checkOutDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Lütfen giriş ve çıkış tarihlerini seçin'),
                  ),
                );
                return;
              }

              if (checkOutDate!.isBefore(checkInDate!)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Çıkış tarihi giriş tarihinden önce olamaz'),
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
                  type: 'hotel',
                  title: hotel.title,
                  date: checkInDate!,
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