class GeneratedPlanPreferences {
  late String _id, trainingsStatus, trainingsType;
  late int numberOfTraininssession;

  GeneratedPlanPreferences(this._id, this.numberOfTraininssession,
      this.trainingsStatus, this.trainingsType);

  Map toJson() {
    return {
      'user_id': _id,
      'numberOfTraininssession': numberOfTraininssession,
      'trainingsStatus': trainingsStatus,
      'trainingsType': trainingsType
    };
  }
}
