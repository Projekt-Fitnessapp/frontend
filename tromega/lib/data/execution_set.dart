// ignore_for_file: constant_identifier_names

enum ExecutionType {
  WARMUP,
  WORKING,
  BACKOFF,
}

class ExecutionSet {
  late ExecutionType executionType;
  late double weight, tenRM;
  late int reps;
  late bool done;

  ExecutionSet(this.executionType, this.reps, this.weight, this.tenRM, this.done);

  ExecutionSet.clone(ExecutionSet executionSet)
      : this(executionSet.executionType, executionSet.reps, executionSet.weight, executionSet.tenRM, executionSet.done);

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
    if ((importMap['reps'] ?? 0) is int) {
      reps = importMap['reps'] ?? 0;
    } else {
      reps = importMap['reps'].round();
    }
    weight = importMap['weight']?.toDouble() ?? 0.0;
    tenRM = importMap['tenRM']?.toDouble() ?? 0.0;
    done = false;
  }

  Map<String, dynamic> toJson() {
    return {
      'executionType': typeToString(executionType),
      'weight': weight,
      'reps': reps,
      '10RM': tenRM,
    };
  }

  String typeToString(ExecutionType type) {
    switch (type) {
      case ExecutionType.WARMUP:
        return 'warmup';
      case ExecutionType.WORKING:
        return 'working';
      case ExecutionType.BACKOFF:
        return 'backoff';
    }
  }
}
