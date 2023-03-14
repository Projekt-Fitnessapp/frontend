import '../data/classes/trainday.dart';

//class TraindayOld {
//  late DateTime date;
//  late bool trained;

//  TraindayOld(this.date, this.trained);
//}

class Trainweek {
  late String week;
  late List<TrainDay> days;

  Trainweek(this.week, this.days);
}
