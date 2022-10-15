import './execution.dart';

class TrainingSession {
  late String _id, userId, trainingDayId;
  late DateTime date;
  late List<Execution> executions;

  TrainingSession(this._id, this.userId, this.trainingDayId, this.date, this.executions);

  TrainingSession.clone(TrainingSession trainingSession)
      : this(trainingSession._id, trainingSession.userId, trainingSession.trainingDayId, trainingSession.date, trainingSession.executions);

  TrainingSession.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    userId = importMap['userId'] ?? '';
    trainingDayId = importMap['trainingDayId'] ?? '';
    date = DateTime.parse(importMap['date'] ?? '19700101');
    executions = (importMap['executions'] ?? []).map<Execution>((executionMap) => Execution.fromJSON(executionMap)).toList();
    print(executions);
  }
}
