import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/listing.dart';

class ListingProvider with ChangeNotifier {
  List<Listing> _listings = [];

  List<Listing> get listings => _listings;

  ListingProvider() {
    _loadListings();
  }

  Future<void> _loadListings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? listingsJson = prefs.getString('listings');
    if (listingsJson != null) {
      final List<dynamic> decodedList = json.decode(listingsJson);
      _listings = decodedList.map((item) => Listing.fromJson(item)).toList();
    } else {
      _addSampleListings();
    }
    notifyListeners();
  }

  Future<void> _saveListings() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(
      _listings.map((listing) => listing.toJson()).toList(),
    );
    await prefs.setString('listings', encodedList);
  }

  void _addSampleListings() {
    // Uçuş ilanları
    _listings.addAll([
      Listing(
        id: 'f1',
        type: 'flight',
        title: 'İstanbul - Antalya',
        description: 'THY ile konforlu uçuş',
        price: 800.0,
        imageUrl: 'assets/images/thy_logo.png',
        details: {
          'airline': 'Türk Hava Yolları',
          'departureTime': '10:00',
          'arrivalTime': '11:30',
          'date': '2024-03-20',
        },
      ),
      Listing(
        id: 'f2',
        type: 'flight',
        title: 'İstanbul - İzmir',
        description: 'Pegasus ile ekonomik uçuş',
        price: 600.0,
        imageUrl: 'assets/images/pegasus_logo.png',
        details: {
          'airline': 'Pegasus',
          'departureTime': '14:00',
          'arrivalTime': '15:15',
          'date': '2024-03-21',
        },
      ),
      Listing(
        id: 'f3',
        type: 'flight',
        title: 'Ankara - İstanbul',
        description: 'AnadoluJet ile konforlu uçuş',
        price: 700.0,
        imageUrl: 'assets/images/ajet_logo.png',
        details: {
          'airline': 'AnadoluJet',
          'departureTime': '09:00',
          'arrivalTime': '10:15',
          'date': '2024-03-22',
        },
      ),
    ]);

    // Restoran ilanları
    _listings.addAll([
      Listing(
        id: 'r1',
        type: 'restaurant',
        title: 'Osmanlı Mutfağı',
        description: 'Geleneksel Türk lezzetleri',
        price: 150.0,
        imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
        details: {
          'cuisine': 'Türk Mutfağı',
          'rating': '4.8',
          'openingHours': '10:00 - 22:00',
        },
      ),
      Listing(
        id: 'r2',
        type: 'restaurant',
        title: 'Balık Restaurant',
        description: 'Taze deniz ürünleri',
        price: 200.0,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        details: {
          'cuisine': 'Deniz Ürünleri',
          'rating': '4.6',
          'openingHours': '12:00 - 23:00',
        },
      ),
    ]);

    // Otel ilanları
    _listings.addAll([
      Listing(
        id: 'h1',
        type: 'hotel',
        title: 'Luxury Palace Hotel',
        description: '5 yıldızlı konfor',
        price: 1500.0,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        details: {
          'stars': '5',
          'location': 'Antalya',
          'amenities': ['Havuz', 'Spa', 'Restaurant'],
        },
      ),
      Listing(
        id: 'h2',
        type: 'hotel',
        title: 'Boutique Hotel',
        description: 'Şehir merkezinde butik otel',
        price: 800.0,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        details: {
          'stars': '4',
          'location': 'İstanbul',
          'amenities': ['WiFi', 'Restaurant', 'Bar'],
        },
      ),
    ]);

    // Araç kiralama ilanları
    _listings.addAll([
      Listing(
        id: 'c1',
        type: 'car',
        title: 'Ekonomik Araç',
        description: 'Yakıt tasarruflu araç',
        price: 250.0,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        details: {
          'brand': 'Renault',
          'model': 'Clio',
          'year': '2023',
          'transmission': 'Manuel',
        },
      ),
      Listing(
        id: 'c2',
        type: 'car',
        title: 'Lüks Araç',
        description: 'Premium segment araç',
        price: 500.0,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        details: {
          'brand': 'BMW',
          'model': '520i',
          'year': '2023',
          'transmission': 'Otomatik',
        },
      ),
    ]);

    _saveListings();
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

  Future<void> addListing(Listing listing) async {
    _listings.add(listing);
    await _saveListings();
    notifyListeners();
  }

  Future<void> updateListing(Listing listing) async {
    final index = _listings.indexWhere((l) => l.id == listing.id);
    if (index != -1) {
      _listings[index] = listing;
      await _saveListings();
      notifyListeners();
    }
  }

  Future<void> removeListing(String id) async {
    _listings.removeWhere((listing) => listing.id == id);
    await _saveListings();
    notifyListeners();
  }
} 