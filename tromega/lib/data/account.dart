class Account {
  late String id, googleId, name, sex;
  late DateTime birthdate;
  late List<String> trainingPlans;

  Account(this.id, this.googleId, this.name, this.birthdate, this.sex, this.trainingPlans);

  Account.fromJSON(Map<String, dynamic> importMap) {
    id = importMap['_id'] ?? '';
    googleId = importMap['googleId'] ?? '';
    name = importMap['name'] ?? '';
    birthdate = DateTime.parse(importMap['birthdate'] ?? '');
    sex = importMap['sex'] ?? '';
    trainingPlans = importMap['trainingPlans'] ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      "google_id" : googleId,
      "name": name,
      "sex": sex,
      "birthdate": birthdate.toIso8601String(),
      "traningPlans": trainingPlans
    };
  }
}
