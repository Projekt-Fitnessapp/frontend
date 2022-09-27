class Set {
  late String executionType;
  late double reps, weight, tenRM;

  Set(this.executionType, this.reps, this.weight, this.tenRM);

  Set.fromJSON(Map<String, dynamic> importMap) {
    executionType = importMap['executionType'] ?? '';
    reps = importMap['reps'] ?? 0;
    weight = importMap['weight'] ?? 0;
    tenRM = importMap['tenRM'] ?? 0;
  }
}
