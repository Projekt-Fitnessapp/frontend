import './set.dart';

class ExerciseUnit {
  late String _id, exerciseId;
  late DateTime date;
  late List<String> notes;
  late List<Set> sets;

  ExerciseUnit(this._id, this.exerciseId, this.date, this.notes, this.sets);

  ExerciseUnit.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'];
    exerciseId = importMap['exerciseId'];
    date = importMap['date'];
    notes = importMap['notes'];
    sets = importMap['sets'];
  }
}
