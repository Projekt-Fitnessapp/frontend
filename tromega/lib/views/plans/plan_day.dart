import 'package:tromega/views/plans/edit_training_view.dart';
import 'package:tromega/views/in_training/track_training_view.dart';

import '../../widgets/plan/exercise_container_plan.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/trainingDay.dart';
import 'package:tromega/data/trainingPlan.dart';

class PlanDayView extends StatefulWidget {
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
      appBar: AppBar_Icon(actions: []),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.trainingDay.name,
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        //alignment: Alignment.topRight,
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 32,
                        onPressed: () async {
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
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrackingView(),
                  ));
            }),
            child: const Text("Training starten")),
        for (var exercise in widget.trainingDay.exercises)
          ExerciseContainerPlan(exercise: exercise)
      ]),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
