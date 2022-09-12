class Exercise {
  late String _id, name, description, gifURL, muscle, equipment;

  Exercise(this._id, this.name, this.description, this.gifURL, this.muscle, this.equipment);

  Exercise.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'];
    name = importMap['name'];
    description = importMap['description'];
    gifURL = importMap['gifURL'];
    muscle = importMap['muscle'];
    equipment = importMap['equipment'];
  }
}