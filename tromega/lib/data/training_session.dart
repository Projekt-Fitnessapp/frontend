import 'package:tromega/data/planned_exercise.dart';

import './execution.dart';
import 'execution_set.dart';
import 'training_day.dart';

class TrainingSession {
  late String id, userId, trainingDayId;
  late DateTime date;
  late List<Execution> executions;

  TrainingSession(this.id, this.userId, this.trainingDayId, this.date, this.executions);

  TrainingSession.clone(TrainingSession trainingSession)
      : this(trainingSession.id, trainingSession.userId, trainingSession.trainingDayId, trainingSession.date, trainingSession.executions);

  TrainingSession.fromJSON(Map<String, dynamic> importMap) {
    id = importMap['_id'] ?? '';
    userId = importMap['userId'] ?? '';
    trainingDayId = importMap['trainingDayId'] ?? '';
    date = DateTime.parse(importMap['date'] ?? '19700101');
    executions = (importMap['executions'] ?? []).map<Execution>((executionMap) => Execution.fromJSON(executionMap)).toList();
  }

  TrainingSession.fromTrainingDay(TrainingDay td) {
    print(td.id);
    print(td.name);

    id = '';
    userId = '';
    trainingDayId = td.id;
    date = DateTime.now();
    executions = td.exercises.map<Execution>((plannedExercise) {
      List<ExecutionSet> newSets = [];
      for (int i = 0; i < plannedExercise.sets; i++) {
        newSets.add(ExecutionSet(ExecutionType.WORKING, plannedExercise.reps, 0, 0, false));
      }

      return Execution('', plannedExercise.exercise, [], newSets, false);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'trainingDayId': trainingDayId,
      'date': DateTime.now().toString(),
      'executions': executions.map((e) => e.toJson()).toList(),
    };
  }
}
