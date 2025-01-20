import 'dart:async';
import 'package:hive/hive.dart';
import '../models/training_card_model.dart';

class HistoryService {
  Future<List<TrainingCard>> getTrainingHistory() async {
    var box = await Hive.openBox<TrainingCard>('trainingCards');
    final history = box.values.toList();
    return history;
  }

  Future<void> updateTrainingDescription(TrainingCard trainingCard) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Symulacja opóźnienia
    print("Opis treningu został zaktualizowany na: ${trainingCard.description}");
  }
}
