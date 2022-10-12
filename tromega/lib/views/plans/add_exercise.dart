import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tromega/widgets/exercise_container.dart';
import 'package:tromega/widgets/exercise_container_adding.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/edit_plan_view_column.dart';
import '../../data/classes.dart';

class AddExercise extends StatefulWidget {
  final Day day;
  AddExercise({Key? key, required this.day}) : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final exercises = [
    Exercise("Kreuzheben", "Rücken", "Langhantel", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/0032.gif"),
    Exercise("Latzug", "Rücken", "Maschine", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/2330.gif"),
    Exercise("Kreuzheben", "Rücken", "Langhantel", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/0032.gif"),
    Exercise("Latzug", "Rücken", "Maschine", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/2330.gif"),
    Exercise("Kreuzheben", "Rücken", "Langhantel", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/0032.gif"),
    Exercise("Latzug", "Rücken", "Maschine", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/2330.gif"),
    Exercise("Kreuzheben", "Rücken", "Langhantel", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/0032.gif"),
    Exercise("Latzug", "Rücken", "Maschine", 3, 10,
        "http://d205bpvrqc9yn1.cloudfront.net/2330.gif")
  ];

  String searchWord = "";

  onSearchTextChanged(String text) {
    List<Exercise> searchResults = [];
    exercises.forEach((exercise) {
      if (text == '' ||
          exercise.name.contains(text) ||
          exercise.muscle.contains(text) ||
          exercise.equipment.contains(text)) {
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
      appBar: AppBar_Icon(),
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
