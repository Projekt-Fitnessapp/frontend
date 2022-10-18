import 'package:tromega/data/exercise.dart';

import './planned_exercise.dart';

class TrainingDay {
  late String id, name;
  late List<PlannedExercise> exercises;

  TrainingDay(this.id, this.name, this.exercises);

  TrainingDay.fromJson(Map<String, dynamic> importMap) {
    id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    exercises = (importMap['exercises'] ?? []).map<PlannedExercise>((exerciseMap) => PlannedExercise.fromJson(exerciseMap)).toList();
  }
}
