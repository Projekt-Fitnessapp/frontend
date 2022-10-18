class Body {
  late String _id, userId, date, height, weight;

  Body(this._id, this.userId, this.date, this.height, this.weight);

  Body.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    userId = importMap['userId'] ?? '';
    date = importMap['date'] ?? '';
    height = importMap['height'] ?? '';
    weight = importMap['weight'] ?? '';
  }
}
