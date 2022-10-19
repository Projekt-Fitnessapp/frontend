import './trainingDay.dart';
import 'dart:convert';

class TrainingPlan {
  late String _id, name;
  late int split, nextDay;
  late List<TrainingDay> trainingDays;

  TrainingPlan(
      this._id, this.name, this.split, this.nextDay, this.trainingDays);

  TrainingPlan.clone(TrainingPlan trainingPlan)
      : this(trainingPlan.getId, trainingPlan.name, trainingPlan.split,
            trainingPlan.nextDay, trainingPlan.trainingDays);

  TrainingPlan.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    split = importMap['split'] ?? 0;
    nextDay = importMap['nextDay'] ?? 0;
    trainingDays = [];
    for (var day in importMap['trainingDays'] ?? []) {
      trainingDays.add(TrainingDay.fromJSON(day));
    }
  }

  String get getId {
    return _id;
  }

  set setId(String id) {
    _id = id;
  }

  Map toJson() {
    List jsonDays = [];
    for (var day in trainingDays) {
      jsonDays.add(day.toJson());
    }
    return {
      '_id': _id,
      'name': name,
      'split': split.toString(),
      'nextDay': nextDay.toString(),
      'trainingDays': jsonDays
    };
  }

  Map toJsonWoId() {
    List jsonDays = [];
    for (var day in trainingDays) {
      jsonDays.add(day.toJson());
    }
    return {
      'name': name,
      'split': split.toString(),
      'nextDay': nextDay.toString(),
      'trainingDays': jsonDays
    };
  }
}
