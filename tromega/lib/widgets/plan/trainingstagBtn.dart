import 'package:flutter/material.dart';
import 'package:tromega/views/plans/plan_day.dart';
import 'package:tromega/data/trainingDay.dart';
import 'package:tromega/data/trainingPlan.dart';

class TrainingstagBtn extends StatefulWidget {
  //Button mit dem jeweiligen Trainingstag der Plan Detail View

  final TrainingDay trainingDay;
  final TrainingPlan trainingPlan;
  final int index;
  const TrainingstagBtn(
      {super.key,
      required this.trainingDay,
      required this.trainingPlan,
      required this.index});

  @override
  State<TrainingstagBtn> createState() => _TrainingstagBtnState();
}

class _TrainingstagBtnState extends State<TrainingstagBtn> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Text("Tag ${widget.index + 1}",
                    style: Theme.of(context).textTheme.headlineLarge)),
            Expanded(
              flex: 7,
              child: FloatingActionButton(
                child: Text(widget.trainingDay.name,
                    style: Theme.of(context).textTheme.headlineLarge),
                onPressed: () async {
                  //Navigation in die PlanDayView mit dem ausgewählten Tag und den trainingsPlan für folgende Views

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
            ),
          ],
        ),
      );
}
