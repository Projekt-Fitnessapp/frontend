class Body {
  late String _id, userId, height, weight;

  Body(this._id, this.userId, this.height, this.weight);

  Body.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    userId = importMap['_userid'] ?? '';
    height = importMap['height'] ?? '1.80';
    weight = importMap['weight'] ?? '70';
  }
}
