import 'dart:async';
import 'package:hive/hive.dart';
import '../models/training_card_model.dart';

class HistoryService {
  Future<List<TrainingCard>> getTrainingHistory() async {
    var box = await Hive.openBox<TrainingCard>('trainingCards');
    final history = box.values.toList();

    for (final training in history) {
      print('--- Trening z dnia: ${training.date} ---');
      // Przechodzimy przez wszystkie ćwiczenia w treningu
      for (final exercise in training.exercises) {
        print('Ćwiczenie: ${exercise.exercise.name}');
        // Przechodzimy przez wszystkie serie (sets)
        for (final set in exercise.sets) {
          print('  - Waga: ${set.weight} kg, Powtórzenia: ${set.repetitions}');
        }
        print('opis: ${training.description}');
      }
    }

    return history;
  }

  Future<void> updateTrainingDescription(TrainingCard trainingCard) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Symulacja opóźnienia
    print("Opis treningu został zaktualizowany na: ${trainingCard.description}");
  }
}
