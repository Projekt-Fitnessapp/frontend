import './exercise.dart';
import 'executionSet.dart';

class Execution {
  late String id, userId;
  late Exercise exercise;
  late List<String> notes;
  late List<ExecutionSet> sets;
  late DateTime date;
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
    userId = importMap['userId'] ?? '';
    exercise = Exercise.fromJSON(importMap['exercise'] ?? {});
    notes = importMap['notes'].map<String>((note) => note.toString()).toList();
    sets = importMap['sets']
        .map<ExecutionSet>((setMap) => ExecutionSet.fromJSON(setMap))
        .toList();
    date = DateTime.parse(importMap['date'] ?? '19700101');
    done = false;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'exercise': exercise.toJson(),
      'notes': notes.toString(),
      'sets': sets.map((e) => e.toJson()).toList(),
      'date': DateTime.now().toString(),
    };
  }
}
