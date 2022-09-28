class Exercise {
  late String name;
  late String muscle;
  late String equipment;
  late int sets;
  late int reps;
  late String gif;

  Exercise(
      this.name, this.muscle, this.equipment, this.sets, this.reps, this.gif);
  Exercise.fromJSON();
}

class Day {
  late String name;
  late List<Exercise> exercises;

  Day(this.name, this.exercises);
  Day.fromJSON();
}

class Training {
  late String name;
  late List<Day> days;

  Training(this.name, this.days);
  Training.fromJSON();
}
