// Author: Steffen
import 'package:flutter/material.dart';
import 'package:tromega/widgets/plan/exercise_container_plan.dart';
import '../../views/in_training/track_training_view.dart';
import '../../data/classes/training_day.dart';
import '../../data/classes/training_plan.dart';

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
  // ignore: unused_field
  int _count = 0;

  //Methode zum aktualisieren von Daten, wird an Child View weitergegeben
  // ignore: unused_element
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
      ElevatedButton(
          onPressed: (() async {
            String trainingId = widget.day.getId;
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackingView(
                    trainingDayId: trainingId,
                    trainingPlanId: widget.trainingPlan.getId,
                  ),
                ));
          }),
          child: const Text("Training starten")),
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
