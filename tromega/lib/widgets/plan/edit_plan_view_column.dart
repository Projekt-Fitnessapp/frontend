import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'exercise_container.dart';
import '../../data/trainingDay.dart';
import '../../data/trainingPlan.dart';
import '../../views/plans/add_exercise.dart';

class EditPlanViewColumn extends StatefulWidget {
  const EditPlanViewColumn(
      {Key? key,
      required this.day,
      required this.update,
      required this.trainingPlan})
      : super(key: key);
  final TrainingDay day;
  final TrainingPlan trainingPlan;
  final ValueChanged<int> update;

  @override
  State<EditPlanViewColumn> createState() => _EditPlanViewColumnState();
}

class _EditPlanViewColumnState extends State<EditPlanViewColumn> {
  int _count = 0;

  // Pass this method to the child page.
  void _update(int count) {
    setState(() => _count = count);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius:
              BorderRadius.circular(20), //border raiuds of dropdown button
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: EditableText(
                    onSubmitted: (value) {
                      widget.day.name = value;
                      widget.update(100);
                    },
                    textAlign: TextAlign.center,
                    controller: TextEditingController(
                      text: widget.day.name,
                    ),
                    style: Theme.of(context).textTheme.headlineLarge!,
                    backgroundCursorColor: Colors.black,
                    cursorColor: Colors.white,
                    focusNode: FocusNode())))
      ]),
      Expanded(
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
        if (widget.day.exercises.isNotEmpty)
          for (var exercise in widget.day.exercises)
            ExerciseContainer(
                update: _update,
                exercises: widget.day.exercises,
                indexExercise: widget.day.exercises.indexOf(exercise)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
                icon: const Icon(Icons.add_circle_outline_sharp),
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExercise(day: widget.day),
                      ));
                  setState(() {});
                },
                label: const Text("Übung hinzufügen")),
            ElevatedButton.icon(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StatefulBuilder(builder: (context, setState) {
                                return Dialog(
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  child: Column(children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                          "Trainingstag unwideruflich löschen?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState() {}
                                                  ;
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Nein")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  widget
                                                      .trainingPlan.trainingDays
                                                      .remove(widget.day);
                                                  widget.update(100);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Ja")),
                                          )
                                        ])
                                  ]),
                                );
                              }),
                            ],
                          ));
                },
                label: const Text("Tag löschen"))
          ],
        )
      ])),
    ]);
  }
}
