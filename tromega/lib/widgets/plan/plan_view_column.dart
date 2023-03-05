import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tromega/widgets/plan/exercise_container_plan.dart';
import 'exercise_container.dart';
import '../../data/trainingDay.dart';
import '../../data/trainingPlan.dart';
import '../../data/filter.dart';
import '../../views/plans/add_exercise.dart';
import '../../views/plans/filter_exercises.dart';

class PlanViewColumn extends StatefulWidget {
  //View einzelner Trainingstage der Edit Training View

  const PlanViewColumn(
      {Key? key, required this.day, required this.trainingPlan})
      : super(key: key);
  final TrainingDay day;
  final TrainingPlan trainingPlan;

  @override
  State<PlanViewColumn> createState() => _PlanViewColumnState();
}

class _PlanViewColumnState extends State<PlanViewColumn> {
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
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.day.name,
                  style: Theme.of(context).textTheme.headlineLarge!,
                  textAlign: TextAlign.center,
                )))
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
              ExerciseContainerPlan(exercise: exercise),
        ]),
      )),
    ]);
  }
}
