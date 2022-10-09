import './exercise.dart';
import 'exerciseSet.dart';

class Execution {
  late Exercise exercise;
  late List<String> notes;
  late List<ExerciseSet> sets;

  Execution(this.exercise, this.notes, this.sets);

  Execution.fromJSON(Map<String, dynamic> importMap) {
    exercise = Exercise.fromJSON(importMap['exercise'] ?? {});
    notes = importMap['notes'].map<String>((note) => note.toString()).toList();
    //executions = (importMap['executions'] ?? []).map((executionMap) => Execution.fromJSON(executionMap)).toList()
    sets = importMap['sets'].map<ExerciseSet>((setMap) => ExerciseSet.fromJSON(setMap)).toList();
  }
}
