class Exercise {
  late String _id, name, instruction, gifUrl, muscle, equipment;

  Exercise(this._id, this.name, this.instruction, this.gifUrl, this.muscle, this.equipment);

  Exercise.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    instruction = importMap['instruction'] ?? '';
    gifUrl = importMap['gifUrl'] ?? '';
    muscle = importMap['muscle'] ?? '';
    equipment = importMap['equipment'] ?? '';
  }
}
