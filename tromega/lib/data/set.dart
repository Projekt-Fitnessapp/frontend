class Set {
  late String type;
  late int reps;
  late double weight, tenRM;

  Set(this.type, this.reps, this.weight, this.tenRM);

  Set.fromJSON(Map<String, dynamic> importMap) {
    type = importMap['type'];
    reps = importMap['reps'];
    weight = importMap['weight'];
    tenRM = importMap['tenRM'];
  }
}
