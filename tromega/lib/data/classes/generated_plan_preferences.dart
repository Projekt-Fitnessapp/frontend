// Erstellt von Tobias Fitzke //

class GeneratedPlanPreferences {
  late String _id, trainingsStatus, trainingsType;
  late int numberOfTrainingssessions;

  GeneratedPlanPreferences(this._id, this.numberOfTrainingssessions,
      this.trainingsStatus, this.trainingsType);

  Map toJSON() {
    return {
      'user_id': _id,
      'numberOfTrainingssessions': numberOfTrainingssessions,
      'trainingsStatus': trainingsStatus,
      'trainingsType': trainingsType
    };
  }

  String getId() {
    return _id;
  }
}
