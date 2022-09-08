import 'package:flutter/material.dart';
import 'exercise_container.dart';

class EditPlanViewColumn extends StatelessWidget {
  const EditPlanViewColumn({Key? key, required this.plan}) : super(key: key);
  final String plan;

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
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(plan, style: Theme.of(context).textTheme.headline1))
      ]),
      ExerciseContainer(),
      ExerciseContainer(),
      ExerciseContainer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline_sharp),
              onPressed: () {},
              label: const Text("Übung hinzufügen"))
        ],
      )
    ]);
  }
}
