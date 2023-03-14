import 'package:flutter/material.dart';
import '../../data/classes/exercise_sets_reps.dart';
import '../../data/classes/training_day.dart';
import './exercise_gif.dart';

class ExerciseContainerAdding extends StatelessWidget {
  //Der Container für die Übungskarten in der  Add Exercise View

  const ExerciseContainerAdding(
      {Key? key, required this.exercise, required this.day})
      : super(key: key);
  final ExerciseSetsReps exercise;
  final TrainingDay day;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          day.exercises.add(exercise);
          Navigator.pop(context);
        },
        child: Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.65),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Row(children: <Widget>[
                  ExerciseGif(gif: exercise.exercise.gifUrl),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: SizedBox(
                              height: 50,
                              child: Text(exercise.exercise.name,
                                  maxLines: 2,
                                  textHeightBehavior: const TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            )),
                        Column(children: <Widget>[
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text("Muskel:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        child: Text(
                                            textAlign: TextAlign.end,
                                            exercise.exercise.muscle
                                                .split(" ")[0],
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium)))
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text("Equipment:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium)),
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                              textAlign: TextAlign.end,
                                              exercise.exercise.equipment,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium)))
                                ]),
                          ),
                        ])
                      ])),
                ]))));
  }
}
