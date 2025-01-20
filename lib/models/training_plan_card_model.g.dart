// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_plan_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingPlanCardModelAdapter extends TypeAdapter<TrainingPlanCardModel> {
  @override
  final int typeId = 6;

  @override
  TrainingPlanCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingPlanCardModel(
      exercises: (fields[0] as List).cast<TrainingExerciseModel>(),
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      type: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrainingPlanCardModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exercises)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingPlanCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
