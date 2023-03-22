// Author: Steffen
class TrainDay {
  late DateTime date;
  late bool trained;

  TrainDay(this.date, this.trained);

  TrainDay.clone(TrainDay trainday) : this(trainday.date, trainday.trained);

  TrainDay.fromJSON(Map<String, dynamic> importMap) {
    date = DateTime.parse(importMap['date'] ?? '19700101');
    trained = importMap['trained'] ?? false;
  }
}

class Trainweek {
  late String week;
  late List<TrainDay> days;

  Trainweek(this.week, this.days);
}
