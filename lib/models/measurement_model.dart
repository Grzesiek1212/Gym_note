import 'package:hive/hive.dart';

part 'measurement_model.g.dart';

@HiveType(typeId: 0)
class Measurement extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final double value;

  @HiveField(3)
  final DateTime date;

  Measurement({
    required this.id,
    required this.type,
    required this.value,
    required this.date,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'date': date.toIso8601String(),
    };
  }
}
