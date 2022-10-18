import 'exercise.dart';

class PlannedExercise {
  late Exercise exercise;
  late int reps, sets;

  PlannedExercise(this.exercise, this.reps, this.sets);

  PlannedExercise.fromJson(Map<String, dynamic> importMap) {
    exercise = Exercise.fromJSON(importMap['exerciseId'] ?? {});
    reps = importMap['reps'] ?? 0;
    sets = importMap['sets'] ?? 0;
  }
}
