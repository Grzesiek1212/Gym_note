import 'dart:async';
import 'package:hive/hive.dart';
import '../models/training_plan_card_model.dart';

class PlanService {
  List<TrainingPlanCardModel> plans = [];

  Future<List<TrainingPlanCardModel>> getPlans(bool isOwnPlans) async {
    var box = await Hive.openBox<TrainingPlanCardModel>('trainingPlanCards');

    final filteredPlans = box.values
        .where((plan) => isOwnPlans ? plan.type == 'own' : plan.type == 'ready')
        .toList();

    return filteredPlans;
  }

  void deletePlan(String planName) async {
    var box = await Hive.openBox<TrainingPlanCardModel>('trainingPlans');
    final planKey = box.keys.firstWhere(
      (key) => box.get(key)?.name == planName,
      orElse: () => null,
    );
    if (planKey != null) {
      await box.delete(planKey);
      print("Plan o nazwie $planName został usunięty.");
    } else {
      print("Nie znaleziono planu o nazwie $planName.");
    }
  }
}
