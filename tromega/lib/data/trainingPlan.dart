import './trainingDay.dart';

class TrainingPlan {
  late String _id, name;
  late int split, nextDay;
  late List<TrainingDay> trainingDays;

  TrainingPlan(
      this._id, this.name, this.split, this.nextDay, this.trainingDays);

  TrainingPlan.clone(TrainingPlan trainingPlan)
      : this(trainingPlan._id, trainingPlan.name, trainingPlan.split,
            trainingPlan.nextDay, trainingPlan.trainingDays);

  TrainingPlan.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    split = importMap['split'] ?? 0;
    nextDay = importMap['nextDay'] ?? 0;
    trainingDays = importMap['trainingDays'] ?? [];
  }
}
