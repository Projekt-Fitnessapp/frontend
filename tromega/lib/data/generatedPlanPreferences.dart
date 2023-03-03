class GeneratedPlanPreferences {
  late String _id, numberOfTraininssession, trainingsStatus, trainingsType;

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
