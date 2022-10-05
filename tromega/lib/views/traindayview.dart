class Trainday {
  late DateTime date;
  late bool trained;

  Trainday(this.date, this.trained);
}

class Trainweek {
  late String week;
  late List<Trainday> days;

  Trainweek(this.week, this.days);
}
