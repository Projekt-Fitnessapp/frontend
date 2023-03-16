class Body {
  late String _id, userId;
  late DateTime date;
  late int height, weight;

  Body(this._id, this.userId, this.date, this.height, this.weight);

  Body.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    userId = importMap['userId'] ?? '';
    date = DateTime.parse(importMap['date'] ?? '19700101');
    height = importMap["height"] ?? 1;
    weight = importMap['weight'] ?? 1;
  }

  Map<String, dynamic> toJSON() {
    return {
      "userId": userId,
      "date": date.toIso8601String(),
      "height": height,
      "weight": weight,
    };
  }

  String getId() {
    return _id;
  }
}
