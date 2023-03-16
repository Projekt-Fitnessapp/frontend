// ignore_for_file: non_constant_identifier_names

class Account {
  late String _id, google_id, name, sex, activePlan;
  late DateTime birthdate;
  late List<String> trainingPlans;

  Account(this._id, this.google_id, this.name, this.birthdate, this.sex,
      this.activePlan, this.trainingPlans);

  Account.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    google_id = importMap['google_id'] ?? '';
    birthdate = DateTime.parse(importMap['birthdate'] ?? '19700101');
    sex = importMap['sex'] ?? '';
    activePlan = importMap['activePlan'] ?? '';
    trainingPlans = (importMap['trainingPlans'] ?? [])
        .map<String>((e) => e.toString())
        .toList();
  }

  Map toJSON() {
    return {
      '_id': _id,
      'name': name,
      'google_id': google_id,
      'birthdate': birthdate.toIso8601String(),
      'sex': sex,
      'trainingPlans': trainingPlans
    };
  }

  Map toJSONNewActivePlan(String newActivePlan) => {
        '_id': _id,
        'name': name,
        'google_id': google_id,
        'birthdate': birthdate.toIso8601String(),
        'activePlan': newActivePlan,
        'sex': sex,
        'trainingPlans': trainingPlans.toString()
      };

  String getId() {
    return _id;
  }
}
