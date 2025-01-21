import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 7)
class PhotoModel {
  @HiveField(0)
  final String photoURL;

  @HiveField(1)
  final DateTime dateAT;

  PhotoModel({
    required this.photoURL,
    required this.dateAT,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      photoURL: map['photoURL'],
      dateAT: DateTime.parse(map['dateAT']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photoURL': photoURL,
      'dateAT': dateAT,
    };
  }

  PhotoModel copyWith({String? photoURL, DateTime? dateAT}) {
    return PhotoModel(
      photoURL: photoURL ?? this.photoURL,
      dateAT: dateAT ?? this.dateAT,
    );
  }
}
