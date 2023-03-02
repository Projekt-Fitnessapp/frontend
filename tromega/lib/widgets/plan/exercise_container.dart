import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../data/exerciseSetsReps.dart';
import 'sets_dialog.dart';
import 'reps_dialog.dart';
import 'exercise_gif.dart';

class ExerciseContainer extends StatefulWidget {
  //Der Container für die Übungskarten in der  Edit Training View

  const ExerciseContainer(
      {Key? key,
      required this.exercises,
      required this.indexExercise,
      required this.update})
      : super(key: key);
  final List<ExerciseSetsReps> exercises;
  final int indexExercise;
  final ValueChanged<int> update;

  @override
  State<ExerciseContainer> createState() => _ExerciseContainerState();
}

class _ExerciseContainerState extends State<ExerciseContainer>
    with TickerProviderStateMixin {
  void _changeSets(int sets) {
    setState(() => widget.exercises[widget.indexExercise].sets = sets);
  }

  void _changeReps(int reps) {
    setState(() => widget.exercises[widget.indexExercise].reps = reps);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.indexExercise < widget.exercises.length) {
      var exercise = widget.exercises[widget.indexExercise];
      return Dismissible(
        key: Key(exercise.exercise.name),
        onDismissed: (direction) {
          //Löschen von ausgewählten Übungen und Aktualisierung
          widget.exercises.remove(exercise);
          setState(() {});
          widget.update(100);
        },
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Löschbestätigung"),
                content: const Text(
                    "Bist du dir sicher, dass du diese Übung löschen willst?"),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Delete")),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
        background: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  Text('Löschen der Übung',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        secondaryBackground: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  Text('Löschen der Übung',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        child: Container(
            height: 120,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.65),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Row(children: <Widget>[
                  ExerciseGif(gif: exercise.exercise.gifUrl),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: SizedBox(
                              height: 50,
                              child: Text(exercise.exercise.name,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            )),
                        Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              SetsDialog(
                                  sets: widget
                                      .exercises[widget.indexExercise].sets,
                                  changeSets: _changeSets),
                              RepsDialog(
                                  reps: widget
                                      .exercises[widget.indexExercise].reps,
                                  changeReps: _changeReps),
                            ])),
                      ])),
                ]))),
      );
    } else {
      return Container();
    }
  }
}
