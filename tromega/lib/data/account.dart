class Account {
  late String _id, google_id, name, birthdate, sex, activePlan;
  late List<String> trainingPlans;

  Account(this._id, this.google_id, this.name, this.birthdate, this.sex,
      this.activePlan, this.trainingPlans);

  Account.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    google_id = importMap['google_id'] ?? '';
    birthdate = importMap['birthdate'] ?? '';
    sex = importMap['sex'] ?? '';
    activePlan = importMap['activePlan'] ?? '';
    trainingPlans = importMap['trainingPlans'] ?? [];
  }

  Map toJsonNewActivePlan(String newActivePlan) => {
        '_id': _id,
        'name': name,
        'google_id': google_id,
        'birthdate': birthdate,
        'activePlan': newActivePlan,
        'sex': sex,
        'trainingPlans': trainingPlans.toString()
      };
}
