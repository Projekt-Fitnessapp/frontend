class StatsPair {
  late int exerciseAmount;
  late DateTime date;

  StatsPair(this.exerciseAmount, this.date);

  int get getExerciseAmount {
    return exerciseAmount;
  }

  DateTime get getDate {
    return date;
  }

  StatsPair.fromJSON(Map<String, dynamic> importMap) {
    exerciseAmount = importMap['exercise_amount'] ?? 0;
    date = importMap['date'] ?? DateTime.utc(2000, 1, 1);
  }
}

class OneGraph {
  late List<StatsPair> graph;

  OneGraph(this.graph);
}
