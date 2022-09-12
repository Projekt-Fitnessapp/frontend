class TrainingUnit {
  late String _id, trainingDayId;
  late DateTime date;
  late List<String> exercises;

  TrainingUnit(this._id, this.trainingDayId, this.date, this.exercises);

  TrainingUnit.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    trainingDayId = importMap['trainingDayId'] ?? '';
    date = DateTime.parse(importMap['date']);
    exercises = List<String>.from(importMap['exercises']);
  }
}
