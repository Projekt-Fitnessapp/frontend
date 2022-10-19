import 'package:flutter/material.dart';
import 'package:tromega/views/plans/plan_details.dart';
import 'package:tromega/data/trainingPlan.dart';

class TrainingsplanBtn extends StatelessWidget {
  //Button mit dem jeweiligen Trainigsplan der Plan Overview View

  final TrainingPlan trainingPlan;

  const TrainingsplanBtn({super.key, required this.trainingPlan});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: Text(trainingPlan.name,
              style: Theme.of(context).textTheme.headlineLarge),
          onPressed: () async {
            //Navigation in die PlanDetailsview mit dem ausgewählten Trainingsplan

            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlanDetailsView(trainingPlan: trainingPlan),
                ));
          },
        ),
      );
}
