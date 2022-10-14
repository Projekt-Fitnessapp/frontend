import 'package:flutter/material.dart';
import 'package:tromega/views/plans/plan_day.dart';
import 'package:tromega/data/trainingDay.dart';
import 'package:tromega/data/trainingPlan.dart';

class TrainingstagBtn extends StatefulWidget {
  final TrainingDay trainingDay;
  final TrainingPlan trainingPlan;
  const TrainingstagBtn(
      {super.key, required this.trainingDay, required this.trainingPlan});

  @override
  State<TrainingstagBtn> createState() => _TrainingstagBtnState();
}

class _TrainingstagBtnState extends State<TrainingstagBtn> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: Text(widget.trainingDay.name,
              style: Theme.of(context).textTheme.headlineLarge),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanDayView(
                    trainingDay: widget.trainingDay,
                    trainingPlan: widget.trainingPlan,
                  ),
                ));
          },
        ),
      );
}
