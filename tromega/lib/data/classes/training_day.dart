import 'exercise_sets_reps.dart';

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

  Map toJSON() {
    List jsonExercises = [];
    for (var exercise in exercises) {
      jsonExercises.add(exercise.toJSON());
    }
    return {
      '_id': _id.replaceAll("\"", ""),
      'name': name,
      'exercises': jsonExercises
    };
  }

  Map toJSONWoId() {
    List jsonExercises = [];
    for (var exercise in exercises) {
      jsonExercises.add(exercise.toJSON());
    }
    return {'name': name, 'exercises': jsonExercises};
  }
}
