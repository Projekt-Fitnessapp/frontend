import './trainingPlan.dart';

class TrainingPlans {
  late List<TrainingPlan> trainingPlans;

  TrainingPlans(this.trainingPlans);

  TrainingPlans.clone(TrainingPlans trainingPlans)
      : this(trainingPlans.trainingPlans);

  TrainingPlans.fromJSON(Map<String, dynamic> importMap) {
    trainingPlans = importMap['traininPlans'] ?? [];
  }
}
