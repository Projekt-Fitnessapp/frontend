class GeneratedPlanPreferences {
  late String _id, days, expertise, sex, age, weight;

  GeneratedPlanPreferences(
      this._id, this.days, this.expertise, this.sex, this.age, this.weight);

  Map toJson() {
    return {
      '_id': _id,
      'days': days,
      'expertise': expertise,
      'sex': sex,
      'age': age,
      'weight': weight
    };
  }

  String getId() {
    return _id;
  }
}
