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
    var box = await Hive.openBox<TrainingCard>('trainingCards');

    final index = box.values.toList().indexWhere((item) => item.date == trainingCard.date);

    if (index != -1) {
      await box.putAt(index, trainingCard);
      print("Opis treningu został zaktualizowany na: ${trainingCard.description}");
    } else {
      print("Nie znaleziono treningu do zaktualizowania.");
    }
  }

  Future<void> deleteTraining(TrainingCard trainingCard) async {
    var box = await Hive.openBox<TrainingCard>('trainingCards');
    final index = box.values.toList().indexWhere((item) => item.description == trainingCard.description);

    if (index != -1) {
      await box.deleteAt(index);
      print("Trening został usunięty: ${trainingCard.description}");
    } else {
      print("Nie znaleziono treningu do usunięcia.");
    }
  }
}
