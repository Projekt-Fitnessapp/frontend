class GeneratedPlanPreferences {
  late String _id, trainingsStatus, trainingsType;
  late int numberOfTrainingssession;

  GeneratedPlanPreferences(this._id, this.numberOfTrainingssession,
      this.trainingsStatus, this.trainingsType);

  Map toJson() {
    return {
      'user_id': _id,
      'numberOfTrainingssession': numberOfTrainingssession,
      'trainingsStatus': trainingsStatus,
      'trainingsType': trainingsType
    };
  }
}
