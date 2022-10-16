import './exercise.dart';
import 'executionSet.dart';

class Execution {
  late String id;
  late Exercise exercise;
  late List<String> notes;
  late List<ExecutionSet> sets;
  late bool done;

  Execution(this.id, this.exercise, this.notes, this.sets, this.done);

  Execution.clone(Execution execution) {
    id = execution.id;
    exercise = execution.exercise;
    notes = List<String>.from(execution.notes);
    sets = execution.sets.map((elem) => ExecutionSet.clone(elem)).toList();
    done = execution.done;
  }

  Execution.fromJSON(Map<String, dynamic> importMap) {
    id = importMap['_id'] ?? '';
    exercise = Exercise.fromJSON(importMap['exercise'] ?? {});
    notes = importMap['notes'].map<String>((note) => note.toString()).toList();
    sets = importMap['sets'].map<ExecutionSet>((setMap) => ExecutionSet.fromJSON(setMap)).toList();
    done = false;
  }
}
