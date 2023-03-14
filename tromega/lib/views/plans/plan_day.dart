import 'package:tromega/views/plans/edit_training_view.dart';
import 'package:tromega/views/in_training/track_training_view.dart';

import '../../widgets/plan/exercise_container_plan.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/classes/training_day.dart';
import 'package:tromega/data/classes/training_plan.dart';

class PlanDayView extends StatefulWidget {
  //Visualisierung von einem Tag eines Trainingsplans
  const PlanDayView(
      {Key? key, required this.trainingDay, required this.trainingPlan})
      : super(key: key);
  final TrainingDay trainingDay;
  final TrainingPlan trainingPlan;

  @override
  State<PlanDayView> createState() => _PlanDayViewState();
}

class _PlanDayViewState extends State<PlanDayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Flexible(
                flex: 9,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.trainingDay.name,
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 32,
                        onPressed: () async {
                          //Navigation zur Editierungs View
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPlanView(
                                  trainingPlan: widget.trainingPlan,
                                ),
                              ));
                        }),
                  ))
            ],
          ),
        ),
        ElevatedButton(
            onPressed: (() async {
              String trainingId = widget.trainingDay.getId;
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TrackingView(trainingDayId: trainingId, trainingPlanId: widget.trainingPlan.getId),
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
          child: ListView(shrinkWrap: true, children: [
            for (var exercise in widget.trainingDay.exercises)
              ExerciseContainerPlan(exercise: exercise)
          ]),
        ))
      ]),
    );
  }
}
