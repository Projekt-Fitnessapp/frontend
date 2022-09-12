import './set.dart';

class Exercise {
  late String _id, exerciseId;
  late DateTime date;
  late List<String> notes;
  late List<Set> sets;

  Exercise(this._id, this.exerciseId, this.date, this.notes, this.sets);

  Exercise.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'];
    exerciseId = importMap['exerciseId'];
    date = importMap['date'];
    notes = importMap['notes'];
    sets = importMap['sets'];
  }
}
