class Body {
  late String _id, userId;
  late DateTime date;
  late int height, weight;

  Body(this._id, this.userId, this.date, this.height, this.weight);

  Body.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    userId = importMap['userId'] ?? '';
    date = DateTime.parse(importMap['date'] ?? '19700101');
    height = int.parse(importMap['height'] ?? '');
    weight = int.parse(importMap['weight'] ?? '');
  }
}
