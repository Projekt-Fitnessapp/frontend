import './exercise.dart';
import './set.dart';

class Execution {
  late Exercise exercise;
  late List<String> notes;
  late List<Set> sets;

  Execution(this.exercise, this.notes, this.sets);

  Execution.fromJSON(Map<String, dynamic> importMap) {
    exercise = Exercise.fromJSON(importMap['exercise'] ?? {});
    notes = importMap['notes'].map<String>((note) => note.toString()).toList();
    //executions = (importMap['executions'] ?? []).map((executionMap) => Execution.fromJSON(executionMap)).toList()
    sets = importMap['sets'].map<Set>((setMap) => Set.fromJSON(setMap)).toList();
  }
}
