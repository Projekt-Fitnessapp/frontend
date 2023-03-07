class StatsPair {
  late int exerciseAmount;
  late String date;

  StatsPair(this.exerciseAmount, this.date);

  int get getExerciseAmount {
    return exerciseAmount;
  }

  String get getDate {
    return date;
  }

  StatsPair.fromJSON(Map<String, dynamic> importMap) {
    exerciseAmount = int.parse(importMap['exercise_amount'] ?? 0);
    date = importMap['date'] ?? '0';
  }
}

class OneGraph {
  late List<StatsPair> graph;

  OneGraph(this.graph);
}
