class GeneratedPlanPreferences {
  late String _id, numberOfTraininssession, trainingsStatus, trainingsType;

  GeneratedPlanPreferences(this._id, this.numberOfTraininssession,
      this.trainingsStatus, this.trainingsType);

  Map toJson() {
    return {
      'id': _id,
      'numberOfTraininssession': numberOfTraininssession,
      'trainingsStatus': trainingsStatus,
      'trainingsType': trainingsType
    };
  }

  GeneratedPlanPreferences.fromJSON(Map<String, dynamic> importMap) {
    setId = importMap['_id'] ?? '';
    numberOfTraininssession = importMap['numberOfTraininssession'] ?? '';
    trainingsStatus = importMap['trainingsStatus'] ?? '';
    trainingsType = importMap['trainingsType'] ?? '';
  }

  Map toJsonWoId() {
    return {
      'numberOfTraininssession': numberOfTraininssession,
      'trainingsStatus': trainingsStatus,
      'trainingsType': trainingsType
    };
  }

  set setId(String id) {
    _id = id;
  }

  String get getId {
    return _id;
  }
}
