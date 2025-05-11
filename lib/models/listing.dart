class Listing {
  final String id;
  final String type;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final Map<String, dynamic> details;

  Listing({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.details,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
      details: json['details'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'details': details,
    };
  }

  Listing copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    Map<String, dynamic>? details,
  }) {
    return Listing(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      details: details ?? this.details,
    );
  }
} 