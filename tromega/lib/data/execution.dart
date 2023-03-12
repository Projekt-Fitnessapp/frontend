import './exercise.dart';
import 'execution_set.dart';

class Execution {
  late String id, userId;
  late Exercise exercise;
  late List<String> notes;
  late List<ExecutionSet> sets;
  late DateTime date;
  late bool done;

  Execution(this.id, this.userId, this.exercise, this.notes, this.sets, this.done);

  Execution.clone(Execution execution) {
    id = execution.id;
    userId = execution.userId;
    exercise = execution.exercise;
    notes = List<String>.from(execution.notes);
    sets = execution.sets.map((elem) => ExecutionSet.clone(elem)).toList();
    done = execution.done;
  }

  Execution.fromJSON(Map<String, dynamic> importMap) {
    id = importMap['_id'] ?? '';
    userId = importMap['userId'] ?? '';
    exercise = Exercise.fromJSON(importMap['exercise'] ?? {});
    notes = importMap['notes'].map<String>((note) => note.toString()).toList();
    sets = importMap['sets'].map<ExecutionSet>((setMap) => ExecutionSet.fromJSON(setMap)).toList();
    date = DateTime.parse(
        importMap['date']?.toString().substring(0, 10) ?? '19700101');
    done = false;
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise.toJson(),
      'notes': notes,
      'sets': sets.map((e) => e.toJson()).toList(),
    };
  }
}
