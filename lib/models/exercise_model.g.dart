// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 1;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      name: fields[0] as String,
      primaryMuscles: (fields[1] as List).cast<String>(),
      secondaryMuscles: (fields[2] as List).cast<String>(),
      level: fields[3] as String,
      description: fields[4] as String,
      youtubeLink: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.primaryMuscles)
      ..writeByte(2)
      ..write(obj.secondaryMuscles)
      ..writeByte(3)
      ..write(obj.level)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.youtubeLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
