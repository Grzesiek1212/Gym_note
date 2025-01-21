// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingCardAdapter extends TypeAdapter<TrainingCard> {
  @override
  final int typeId = 5;

  @override
  TrainingCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingCard(
      exercises: (fields[0] as List).cast<TrainingExerciseModel>(),
      date: fields[1] as DateTime,
      duration: fields[2] as int,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrainingCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exercises)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
