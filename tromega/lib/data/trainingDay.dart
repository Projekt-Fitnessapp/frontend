import './exerciseSetsReps.dart';

class TrainingDay {
  late String _id, name;
  late List<ExerciseSetsReps> exercises;

  TrainingDay(this._id, this.name, this.exercises);

  TrainingDay.clone(TrainingDay trainingDay)
      : this(trainingDay._id, trainingDay.name, trainingDay.exercises);

  TrainingDay.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    exercises = importMap['exercises'] ?? [];
  }
}
