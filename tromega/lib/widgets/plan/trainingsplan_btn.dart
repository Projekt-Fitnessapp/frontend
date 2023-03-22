import 'package:flutter/material.dart';
import 'package:tromega/views/plans/plan_details.dart';
import 'package:tromega/data/classes/training_plan.dart';

class TrainingsplanBtn extends StatelessWidget {
  //Button mit dem jeweiligen Trainigsplan der Plan Overview View

  final TrainingPlan trainingPlan;
  final String activePlanId;

  const TrainingsplanBtn(
      {super.key, required this.trainingPlan, required this.activePlanId});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          shape: activePlanId == trainingPlan.getId
              ? RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.green),
                  borderRadius: BorderRadius.circular(10))
              : RoundedRectangleBorder(
                  side: BorderSide(
                      width: 2, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(10)),
          child: Text(trainingPlan.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineLarge),
          onPressed: () async {
            //Navigation in die PlanDetailsview mit dem ausgewählten Trainingsplan
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanDetailsView(
                      trainingPlan: trainingPlan, activePlanId: activePlanId),
                ));
          },
        ),
      );
}
