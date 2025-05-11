import 'package:flutter/material.dart';
import '../models/listing.dart';

class ListingProvider with ChangeNotifier {
  final List<Listing> _listings = [];

  List<Listing> get listings => _listings;

  // Örnek ilanları ekle
  ListingProvider() {
    _addSampleListings();
  }

  void _addSampleListings() {
    // Uçak bileti ilanları
    _listings.addAll([
      Listing(
        id: 'f1',
        type: 'flight',
        title: 'İstanbul - Antalya',
        description: 'THY ile konforlu seyahat',
        price: 1200.0,
        imageUrl: 'assets/images/flight1.jpg',
        details: {
          'airline': 'THY',
          'departureTime': '10:00',
          'arrivalTime': '11:30',
          'date': '2024-05-15',
        },
      ),
      Listing(
        id: 'f2',
        type: 'flight',
        title: 'İstanbul - İzmir',
        description: 'Pegasus ile ekonomik uçuş',
        price: 800.0,
        imageUrl: 'assets/images/flight2.jpg',
        details: {
          'airline': 'Pegasus',
          'departureTime': '14:30',
          'arrivalTime': '15:45',
          'date': '2024-05-20',
        },
      ),
      Listing(
        id: 'f3',
        type: 'flight',
        title: 'Ankara - İstanbul',
        description: 'AnadoluJet ile hızlı ulaşım',
        price: 600.0,
        imageUrl: 'assets/images/flight3.jpg',
        details: {
          'airline': 'AnadoluJet',
          'departureTime': '08:00',
          'arrivalTime': '09:15',
          'date': '2024-05-18',
        },
      ),
      Listing(
        id: 'f4',
        type: 'flight',
        title: 'İstanbul - Trabzon',
        description: 'SunExpress ile Karadeniz turu',
        price: 900.0,
        imageUrl: 'assets/images/flight4.jpg',
        details: {
          'airline': 'SunExpress',
          'departureTime': '12:00',
          'arrivalTime': '13:30',
          'date': '2024-05-22',
        },
      ),
    ]);

    // Restoran ilanları
    _listings.addAll([
      Listing(
        id: 'r1',
        type: 'restaurant',
        title: 'Lezzet Durağı',
        description: 'Geleneksel Türk mutfağı',
        price: 150.0,
        imageUrl: 'assets/images/restaurant1.jpg',
        details: {
          'cuisine': 'Türk Mutfağı',
          'capacity': 50,
          'workingHours': '09:00-23:00',
        },
      ),
      Listing(
        id: 'r2',
        type: 'restaurant',
        title: 'Deniz Mahsulleri',
        description: 'Taze deniz ürünleri',
        price: 250.0,
        imageUrl: 'assets/images/restaurant2.jpg',
        details: {
          'cuisine': 'Deniz Ürünleri',
          'capacity': 30,
          'workingHours': '11:00-22:00',
        },
      ),
      Listing(
        id: 'r3',
        type: 'restaurant',
        title: 'Uzak Doğu Lezzetleri',
        description: 'Otantik Asya mutfağı',
        price: 180.0,
        imageUrl: 'assets/images/restaurant3.jpg',
        details: {
          'cuisine': 'Asya Mutfağı',
          'capacity': 40,
          'workingHours': '12:00-23:00',
        },
      ),
      Listing(
        id: 'r4',
        type: 'restaurant',
        title: 'İtalyan Ristorante',
        description: 'Otantik İtalyan mutfağı',
        price: 200.0,
        imageUrl: 'assets/images/restaurant4.jpg',
        details: {
          'cuisine': 'İtalyan Mutfağı',
          'capacity': 35,
          'workingHours': '10:00-22:00',
        },
      ),
    ]);

    // Otel ilanları
    _listings.addAll([
      Listing(
        id: 'h1',
        type: 'hotel',
        title: 'Lüks Otel',
        description: '5 yıldızlı konaklama',
        price: 800.0,
        imageUrl: 'assets/images/hotel1.jpg',
        details: {
          'stars': 5,
          'roomType': 'Deluxe',
          'amenities': ['Havuz', 'Spa', 'Restoran'],
        },
      ),
      Listing(
        id: 'h2',
        type: 'hotel',
        title: 'Sahil Resort',
        description: 'Deniz manzaralı tatil',
        price: 600.0,
        imageUrl: 'assets/images/hotel2.jpg',
        details: {
          'stars': 4,
          'roomType': 'Suite',
          'amenities': ['Plaj', 'Havuz', 'Spa', 'Restoran'],
        },
      ),
      Listing(
        id: 'h3',
        type: 'hotel',
        title: 'Butik Otel',
        description: 'Şehir merkezinde konfor',
        price: 400.0,
        imageUrl: 'assets/images/hotel3.jpg',
        details: {
          'stars': 3,
          'roomType': 'Standart',
          'amenities': ['Restoran', 'Otopark'],
        },
      ),
      Listing(
        id: 'h4',
        type: 'hotel',
        title: 'Dağ Evi',
        description: 'Doğa ile iç içe',
        price: 300.0,
        imageUrl: 'assets/images/hotel4.jpg',
        details: {
          'stars': 3,
          'roomType': 'Bungalov',
          'amenities': ['Şömine', 'Restoran', 'Doğa Yürüyüşü'],
        },
      ),
    ]);

    // Araç kiralama ilanları
    _listings.addAll([
      Listing(
        id: 'c1',
        type: 'car',
        title: 'Ekonomik Araç',
        description: 'Günlük kiralama',
        price: 300.0,
        imageUrl: 'assets/images/car1.jpg',
        details: {
          'brand': 'Toyota',
          'model': 'Corolla',
          'year': 2023,
          'transmission': 'Otomatik',
        },
      ),
      Listing(
        id: 'c2',
        type: 'car',
        title: 'Lüks Sedan',
        description: 'Konforlu seyahat',
        price: 600.0,
        imageUrl: 'assets/images/car2.jpg',
        details: {
          'brand': 'Mercedes',
          'model': 'E-Class',
          'year': 2023,
          'transmission': 'Otomatik',
        },
      ),
      Listing(
        id: 'c3',
        type: 'car',
        title: 'SUV',
        description: 'Geniş aile aracı',
        price: 500.0,
        imageUrl: 'assets/images/car3.jpg',
        details: {
          'brand': 'BMW',
          'model': 'X5',
          'year': 2023,
          'transmission': 'Otomatik',
        },
      ),
      Listing(
        id: 'c4',
        type: 'car',
        title: 'Spor Araç',
        description: 'Keyifli sürüş deneyimi',
        price: 800.0,
        imageUrl: 'assets/images/car4.jpg',
        details: {
          'brand': 'Porsche',
          'model': '911',
          'year': 2023,
          'transmission': 'Otomatik',
        },
      ),
    ]);
  }

  List<Listing> getListingsByType(String type) {
    return _listings.where((listing) => listing.type == type).toList();
  }

  Listing? getListingById(String id) {
    try {
      return _listings.firstWhere((listing) => listing.id == id);
    } catch (e) {
      return null;
    }
  }
} 