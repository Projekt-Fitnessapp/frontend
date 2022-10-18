class Exercise {
  late String id, name, instruction, gifUrl, muscle, equipment;

  Exercise(this.id, this.name, this.instruction, this.gifUrl, this.muscle,
      this.equipment);

  Exercise.fromJSON(Map<String, dynamic> importMap) {
    id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    instruction = importMap['instruction'] ?? '';
    gifUrl = importMap['gifUrl'] ?? '';
    muscle = importMap['muscle'] ?? '';
    equipment = importMap['equipment'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'instruction': instruction,
      'gifUrl': gifUrl,
      'muscle': muscle,
      'equipment': equipment,
    };
  }
}
