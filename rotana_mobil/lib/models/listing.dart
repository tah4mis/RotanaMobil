class Listing {
  final String id;
  final String type; // 'flight', 'restaurant', 'hotel', 'car'
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final Map<String, dynamic> details; // Her hizmet türü için özel detaylar

  Listing({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.details,
  });
} 