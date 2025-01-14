class Measurement {
  final int id;
  final int userId;
  final String type;
  final double value;
  final DateTime date;

  Measurement({
    required this.id,
    required this.userId,
    required this.type,
    required this.value,
    required this.date,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      value: json['value'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'value': value,
      'date': date.toIso8601String(),
    };
  }
}