class ExecutionSet {
  late String executionType;
  late double reps, weight, tenRM;
  late bool done;

  ExecutionSet(this.executionType, this.reps, this.weight, this.tenRM, this.done);

  ExecutionSet.clone(ExecutionSet executionSet)
      : this(executionSet.executionType, executionSet.reps, executionSet.weight, executionSet.tenRM, executionSet.done);

  ExecutionSet.fromJSON(Map<String, dynamic> importMap) {
    executionType = importMap['executionType'] ?? '';
    reps = importMap['reps'] ?? 0;
    weight = importMap['weight'] ?? 0;
    tenRM = importMap['tenRM'] ?? 0;
    done = false;
  }
}
