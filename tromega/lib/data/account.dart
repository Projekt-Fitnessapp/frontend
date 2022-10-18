class Account {
  late String _id, google_id, name, birthdate, sex;
  late List<String> trainingPlans;

  Account(this._id, this.google_id, this.name, this.birthdate, this.sex,
      this.trainingPlans);

  Account.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    google_id = importMap['google_id'] ?? '';
    birthdate = importMap['birthdate'] ?? '';
    sex = importMap['sex'] ?? '';
    trainingPlans = importMap['trainingPlans'] ?? [];
  }
}
