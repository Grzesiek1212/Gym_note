// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingExerciseModelAdapter extends TypeAdapter<TrainingExerciseModel> {
  @override
  final int typeId = 4;

  @override
  TrainingExerciseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingExerciseModel(
      exercise: fields[0] as Exercise,
      sets: (fields[1] as List).cast<ExerciseSet>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrainingExerciseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.exercise)
      ..writeByte(1)
      ..write(obj.sets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingExerciseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
