import 'package:flutter/material.dart';
import 'package:tromega/data/classes/exercise_sets_reps.dart';
import 'package:tromega/widgets/plan/exercise_container_adding.dart';
import '../../views/plans/filter_exercises.dart';
import '../../widgets/shared/app_bar.dart';
import '../../data/classes/training_day.dart';
import '../../data/classes/filter.dart';
import '../../data/http_helper.dart';

class AddExercise extends StatefulWidget {
  //View zum Hinzufügen von Übungen zu einem Trainingsplan
  final TrainingDay day;
  Filter filter;
  AddExercise({Key? key, required this.day, required this.filter})
      : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  var exercises = [];
  List<ExerciseSetsReps> initExercises = [];

  String searchWord = "";

  late HttpHelper httpHelper;
  bool fetching = true;

  @override
  initState() {
    httpHelper = const HttpHelper();
    fetchData(); //Übungen abfragen
    super.initState();
  }

  //Suche nach Übungen, Muskeln und Equipment
  onSearchTextChanged(String text) {
    List<ExerciseSetsReps> searchResults = [];
    for (var exercise in exercises) {
      if (text == '' ||
          exercise.exercise.name.contains(text) ||
          exercise.exercise.muscle.contains(text) ||
          exercise.exercise.equipment.contains(text)) {
        searchResults.add(exercise);
      }
    }
    return searchResults;
  }

  @override
  Widget build(BuildContext context) {
    var searchResultsExercises = onSearchTextChanged(searchWord);
    var searchController = TextEditingController(text: searchWord);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBarIcon(actions: const []),
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3.0,
                                    color: Theme.of(context).primaryColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextField(
                                controller: searchController,
                                onSubmitted: (value) {
                                  searchWord = value;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    hintText: "Search",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                        icon: const Icon(Icons.cancel_outlined),
                                        color: Colors.white,
                                        onPressed: (() {
                                          searchController.clear();
                                          searchWord = "";
                                          setState(() {});
                                        }))),
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(Icons.filter_list_alt),
                            alignment: Alignment.topRight,
                            iconSize: 32,
                            onPressed: () async {
                              widget.filter = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FilterView(filter: widget.filter)));
                              setState(() {
                                fetchData();
                              });
                            }),
                      )
                    ],
                  )),
              Expanded(
                  child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.purple
                    ],
                    stops: [
                      0.0,
                      0.05,
                      0.95,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child:
                    ListView(scrollDirection: Axis.vertical, children: <Widget>[
                  for (var exercise in searchResultsExercises)
                    //Übungskarten
                    ExerciseContainerAdding(
                        exercise: exercise, day: widget.day),
                ]),
              ))
            ]),
    );
  }

  void fetchData() async {
    initExercises =
        await httpHelper.getExercise(); //Abfragen der Übungen von der API
    initExercises = filterData(initExercises);
    setState(() {
      exercises = initExercises;
      fetching = false;
    });
  }

  List<ExerciseSetsReps> filterData(initExercises) {
    List<ExerciseSetsReps> filteredExercises = [];
    if (!(widget.filter.equipment.isEmpty && widget.filter.muscle.isEmpty)) {
      for (var exercise in initExercises) {
        if ((widget.filter.equipment.isEmpty ||
                widget.filter.equipment
                    .contains(exercise.exercise.equipment)) &&
            (widget.filter.muscle.isEmpty ||
                widget.filter.muscle
                    .contains(exercise.exercise.muscle.split(" ")[0]))) {
          filteredExercises.add(exercise);
        }
      }
    } else {
      filteredExercises = initExercises;
    }
    return filteredExercises;
  }
}
