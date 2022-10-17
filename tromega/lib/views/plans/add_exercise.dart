import 'package:flutter/material.dart';
import 'package:tromega/data/exerciseSetsReps.dart';
import 'package:tromega/widgets/plan/exercise_container_adding.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import '../../data/trainingDay.dart';
import '../../data/exercise.dart';
import '../../data/exerciseSetsReps.dart';

class AddExercise extends StatefulWidget {
  final TrainingDay day;
  AddExercise({Key? key, required this.day}) : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final exercises = [
    ExerciseSetsReps(
        Exercise(
          "",
          "Deadlift",
          "Lift the bar.",
          "http://d205bpvrqc9yn1.cloudfront.net/0032.gif",
          "back",
          "barbell",
        ),
        3,
        10),
    ExerciseSetsReps(
        Exercise(
          "",
          "Lat Pulldown",
          "Pull the bar.",
          "http://d205bpvrqc9yn1.cloudfront.net/2330.gif",
          "back",
          "barbell",
        ),
        3,
        10)
  ];

  String searchWord = "";

  onSearchTextChanged(String text) {
    List<ExerciseSetsReps> searchResults = [];
    exercises.forEach((exercise) {
      if (text == '' ||
          exercise.exercise.name.contains(text) ||
          exercise.exercise.muscle.contains(text) ||
          exercise.exercise.equipment.contains(text)) {
        searchResults.add(exercise);
      }
    });
    return searchResults;
  }

  @override
  Widget build(BuildContext context) {
    var searchResultsExercises = onSearchTextChanged(searchWord);
    var searchController = TextEditingController(text: searchWord);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar_Icon(actions: []),
      body: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(
              child: IconButton(
                  icon: const Icon(Icons.close),
                  alignment: Alignment.topLeft,
                  iconSize: 32,
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          Expanded(
              child: IconButton(
                  icon: const Icon(Icons.filter_list_alt),
                  alignment: Alignment.topRight,
                  iconSize: 32,
                  onPressed: () {}))
        ]),
        Padding(
            padding: EdgeInsets.all(20),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3.0, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (value) {
                      searchWord = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            color: Colors.white,
                            onPressed: (() {
                              searchController.clear();
                              searchWord = "";
                              setState(() {});
                            }))),
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ))),
        Expanded(
            child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          for (var exercise in searchResultsExercises)
            ExerciseContainerAdding(exercise: exercise, day: widget.day),
        ]))
      ]),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
