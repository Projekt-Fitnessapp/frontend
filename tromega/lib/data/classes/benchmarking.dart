class Benchmarking {
  late String _id, userId, exercise_name;
  late int exercise_amount, week_counter;

  Benchmarking(this._id, this.userId, this.exercise_name, this.exercise_amount,
      this.week_counter);

  Benchmarking.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    userId = importMap['userId'] ?? '';
    exercise_name = importMap['exercise_name'] ?? '';
    exercise_amount = importMap['exercise_amount'] ?? 1;
    week_counter = importMap['week_counter'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "exercise_name": exercise_name,
      "exercise_amount": exercise_amount,
    };
  }
}
