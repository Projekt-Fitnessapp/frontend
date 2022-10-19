import './exerciseSetsReps.dart';
import 'dart:convert';

class TrainingDay {
  late String _id, name;
  late List<ExerciseSetsReps> exercises;

  TrainingDay(this._id, this.name, this.exercises);

  TrainingDay.clone(TrainingDay trainingDay)
      : this(trainingDay.getId, trainingDay.name, trainingDay.exercises);

  TrainingDay.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    exercises = [];
    for (var exercise in importMap['exercises']) {
      exercises.add(ExerciseSetsReps.fromJSON(exercise));
    }
  }

  String get getId {
    return _id;
  }

  Map toJson() {
    List jsonExercises = [];
    for (var exercise in exercises) {
      jsonExercises.add(exercise.toJson());
    }
    return {
      '_id': _id.replaceAll("\"", ""),
      'name': name,
      'exercises': jsonExercises
    };
  }

  Map toJsonWoId() {
    List jsonExercises = [];
    for (var exercise in exercises) {
      jsonExercises.add(exercise.toJson());
    }
    return {'name': name, 'exercises': jsonExercises};
  }
}
