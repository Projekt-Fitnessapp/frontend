import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'exercise_container.dart';
import '../../data/classes/training_day.dart';
import '../../data/classes/training_plan.dart';
import '../../data/classes/filter.dart';
import '../../views/plans/add_exercise.dart';
import '../../views/plans/filter_exercises.dart';

class EditPlanViewColumn extends StatefulWidget {
  //View einzelner Trainingstage der Edit Training View

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

  //Methode zum aktualisieren von Daten, wird an Child View weitergegeben
  void _update(int count) {
    setState(() => _count = count);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    showCursor: true,
                    toolbarOptions: const ToolbarOptions(
                      paste: true,
                      cut: true,
                      copy: true,
                      selectAll: true,
                    ),
                    enableInteractiveSelection: true,
                    onEditingComplete: () {
                      widget.update(100);
                    },
                    onChanged: (value) {
                      //Aktualisiserung des Trainingsplan Namens
                      widget.day.name = value;
                    },
                    onSubmitted: (value) {
                      //Aktualisiserung des Trainingsplan Namens
                      widget.day.name = value;
                    },
                    textAlign: TextAlign.center,
                    controller: TextEditingController(
                      text: widget.day.name,
                    ),
                    style: Theme.of(context).textTheme.headlineLarge!,
                    focusNode: FocusNode())))
      ]),
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
                    //Navigation in die Add Exercise View mit ausgewähltem Tag
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExercise(
                              day: widget.day, filter: Filter([], [])),
                        ));
                    setState(() {});
                  },
                  label: const Text("Übung hinzufügen")),
              ElevatedButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    //Dialog um fehlerhaftes Löschen zu vermeiden
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Nein")),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    //Trainingstag löschen
                                                    widget.trainingPlan
                                                        .trainingDays
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
                  label: const Text("Tag löschen")),
              const SizedBox(height: 20)
            ],
          )
        ]),
      )),
    ]);
  }
}
