class ExerciseSet {
  late String executionType;
  late double reps, weight, tenRM;

  ExerciseSet(this.executionType, this.reps, this.weight, this.tenRM);

  ExerciseSet.fromJSON(Map<String, dynamic> importMap) {
    executionType = importMap['executionType'] ?? '';
    reps = importMap['reps'] ?? 0;
    weight = importMap['weight'] ?? 0;
    tenRM = importMap['tenRM'] ?? 0;
  }
}
