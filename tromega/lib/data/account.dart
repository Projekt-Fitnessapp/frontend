class Account {
  late String id, name, sex;
  late DateTime birthdate;
  late List<String> trainingPlans;

  Account(this.id, this.name, this.birthdate, this.sex, this.trainingPlans);

  Account.fromJSON(Map<String, dynamic> importMap) {
    id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    birthdate = DateTime.parse(importMap['birthdate'] ?? '');
    sex = importMap['sex'] ?? '';
    trainingPlans = importMap['trainingPlans'] ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "sex": sex,
      "birthdate": birthdate.toIso8601String(),
      "traningPlans": trainingPlans
    };
  }
}
