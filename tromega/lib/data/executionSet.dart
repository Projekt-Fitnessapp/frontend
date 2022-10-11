// ignore_for_file: file_names, constant_identifier_names

enum ExecutionType {
  WARMUP,
  WORKING,
  BACKOFF,
}

class ExecutionSet {
  late ExecutionType executionType;
  late double reps, weight, tenRM;
  late bool done;

  ExecutionSet(
      this.executionType, this.reps, this.weight, this.tenRM, this.done);

  ExecutionSet.clone(ExecutionSet executionSet)
      : this(executionSet.executionType, executionSet.reps, executionSet.weight,
            executionSet.tenRM, executionSet.done);

  ExecutionSet.fromJSON(Map<String, dynamic> importMap) {
    switch (importMap['executionType']) {
      case 'warmup':
        executionType = ExecutionType.WARMUP;
        break;
      case 'backoff':
        executionType = ExecutionType.WARMUP;
        break;
      default:
        executionType = ExecutionType.WORKING;
    }

    reps = importMap['reps'] ?? 0;
    weight = importMap['weight'] ?? 0;
    tenRM = importMap['tenRM'] ?? 0;
    done = false;
  }
}
