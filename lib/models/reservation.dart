class Reservation {
  final String id;
  final String type;
  final String title;
  final DateTime date;
  final String status;

  Reservation({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  Reservation copyWith({
    String? id,
    String? type,
    String? title,
    DateTime? date,
    String? status,
  }) {
    return Reservation(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
} 