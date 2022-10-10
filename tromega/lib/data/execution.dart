import './exercise.dart';
import 'executionSet.dart';

class Execution {
  late Exercise exercise;
  late List<String> notes;
  late List<ExecutionSet> sets;
  late bool done;

  Execution(this.exercise, this.notes, this.sets, this.done);

  Execution.clone(Execution execution) : this(execution.exercise, execution.notes, execution.sets, execution.done);

  Execution.fromJSON(Map<String, dynamic> importMap) {
    exercise = Exercise.fromJSON(importMap['exercise'] ?? {});
    notes = importMap['notes'].map<String>((note) => note.toString()).toList();
    //executions = (importMap['executions'] ?? []).map((executionMap) => Execution.fromJSON(executionMap)).toList()
    sets = importMap['sets'].map<ExecutionSet>((setMap) => ExecutionSet.fromJSON(setMap)).toList();
    done = false;
  }
}
