class TripStatus {
  static const String booked = 'Booked';
  static const String completed = 'Completed';
  static const String cancelled = 'Cancelled';
}

class Trip {
  const Trip({
    required this.id,
    required this.title,
    required this.date,
    required this.pickup,
    required this.drop,
    required this.status,
  });

  final int id;
  final String title;
  final String date;
  final String pickup;
  final String drop;
  final String status;

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as int,
      title: json['title'] as String,
      date: json['date'] as String,
      pickup: json['pickup'] as String,
      drop: json['drop'] as String,
      status: json['status'] as String,
    );
  }

  Trip copyWith({
    int? id,
    String? title,
    String? date,
    String? pickup,
    String? drop,
    String? status,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      pickup: pickup ?? this.pickup,
      drop: drop ?? this.drop,
      status: status ?? this.status,
    );
  }
}
