import 'package:flutter/material.dart';
import '../views/plans/classes.dart';
import 'package:numberpicker/numberpicker.dart';

class ExerciseContainer extends StatefulWidget {
  const ExerciseContainer(
      {Key? key,
      required this.exercises,
      required this.indexExercise,
      required this.update})
      : super(key: key);
  final List<Exercise> exercises;
  final int indexExercise;
  final ValueChanged<int> update;

  @override
  State<ExerciseContainer> createState() => _ExerciseContainerState();
}

class _ExerciseContainerState extends State<ExerciseContainer> {
  @override
  Widget build(BuildContext context) {
    if (widget.indexExercise < widget.exercises.length) {
      var exercise = widget.exercises[widget.indexExercise];
      return Container(
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          height: 110,
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
                Image.network(
                  exercise.gif,
                  fit: BoxFit.cover,
                  height: 110,
                  alignment: Alignment.center,
                ),
                Expanded(
                    child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(exercise.name,
                            style: Theme.of(context).textTheme.headline1)),
                    Expanded(
                        child: IconButton(
                            alignment: Alignment.topRight,
                            icon: const Icon(Icons.close),
                            iconSize: 15,
                            onPressed: () {
                              widget.exercises.remove(exercise);
                              setState(() {});
                              widget.update(100);
                            }))
                  ]),
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              child: Text("${exercise.sets} Sätze"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                            builder: (context, setState) {
                                          return Dialog(
                                              insetPadding:
                                                  const EdgeInsets.all(150),
                                              backgroundColor: Theme.of(context)
                                                  .backgroundColor,
                                              child: SizedBox(
                                                width: double.minPositive,
                                                child: NumberPicker(
                                                  textStyle: const TextStyle(
                                                      fontFamily:
                                                          "Proxima Nova",
                                                      color: Colors.white),
                                                  minValue: 0,
                                                  maxValue: 10,
                                                  value: exercise.sets,
                                                  onChanged: (int value) {
                                                    exercise.sets = value;
                                                    setState(() {});
                                                    this.setState(() {});
                                                  },
                                                ),
                                              ));
                                        }));
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              child: Text("${exercise.reps} Wdh"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                            builder: (context, setState) {
                                          return Dialog(
                                              insetPadding:
                                                  const EdgeInsets.all(150),
                                              backgroundColor: Theme.of(context)
                                                  .backgroundColor,
                                              child: NumberPicker(
                                                textStyle: const TextStyle(
                                                    fontFamily: "Proxima Nova",
                                                    color: Colors.white),
                                                minValue: 0,
                                                maxValue: 100,
                                                value: exercise.reps,
                                                onChanged: (int value) {
                                                  exercise.reps = value;
                                                  setState(() {});
                                                  this.setState(() {});
                                                },
                                              ));
                                        }));
                              },
                            ))
                      ])),
                ])),
              ])));
    } else {
      return Container();
    }
  }
}
