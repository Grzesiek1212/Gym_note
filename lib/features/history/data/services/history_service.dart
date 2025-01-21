import 'dart:async';
import 'package:hive/hive.dart';
import '../../../training/data/models/training_card_model.dart';

class HistoryService {
  Future<List<TrainingCard>> getTrainingHistory() async {
    var box = await Hive.openBox<TrainingCard>('trainingCards');
    final history = box.values.toList();
    return history;
  }

  Future<void> updateTrainingDescription(TrainingCard trainingCard) async {
    // TODO aktualizacja opisu
    print(
        "Opis treningu został zaktualizowany na: ${trainingCard.description}");
  }
}
