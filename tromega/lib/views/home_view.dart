// Author: Maik
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import '../../data/http_helper.dart';
import '../data/classes/trainday.dart';
import '../data/classes/quote.dart';
import '../views/in_training/track_training_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.onSelectTab}) : super(key: key);
  final Function onSelectTab;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DateTime dateToday;
  late Color colorDot;
  late HttpHelper httpHelper;
  late Trainweek trainigsDaten;
  late String nextTraining;
  bool fetching = true;
  final rng = Random();
  late int rnd;

  List<Quote> quotes = [
    Quote("Arnold Schwarzenegger",
        "The resistance that you fight physically in the gym and the resistance that you fight in life can only build a strong character."),
    Quote("Ronnie Coleman",
        "Everybody wants to be a bodybuilder, but nobody wants to lift no heavy-ass weights!"),
    Quote("Jay Cutler",
        "For me, life is continuously being hungry. The meaning of life is not simply to exist, to survive, but to move ahead, to go up, to achieve, to conquer."),
    Quote("Dorian Yates",
        "If you're capable of sending a legible text message between sets, you probably aren't working hard enough."),
    Quote("Frank Zane",
        "The most important thing about motivation is goal setting. You should always have a goal.")
  ];

  @override
  void initState() {
    httpHelper = const HttpHelper();
    rnd = rng.nextInt(4);
    fetchData();
    dateToday = DateTime.now();
    colorDot = const Color.fromARGB(1000, 4, 146, 240);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(152.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: fetching
                  ? const Center(child: CircularProgressIndicator())
                  : Column(children: [
                      Container(
                          height: 135,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CalendarTimeline(
                              //Creates timeline in appbar with timespan of 14 days
                              initialDate: dateToday,
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 7)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 7)),
                              dayColor: Colors.black,
                              activeBackgroundDayColor: const Color.fromARGB(
                                  1000, 4, 146, 240), //rgba(4,146,240,1.000)
                              onDateSelected: (date) {
                                var daysBack = DateTime.now().day - date.day;
                                if (daysBack > 0) {
                                  if (trainigsDaten
                                      .days[daysBack - 1].trained) {
                                    colorDot = const Color.fromARGB(
                                        1000,
                                        240,
                                        157,
                                        2); //when someone trained on that date, the dots turn yellow
                                  } else {
                                    colorDot =
                                        const Color.fromARGB(1000, 4, 146, 240);
                                  }
                                } else {
                                  colorDot =
                                      const Color.fromARGB(1000, 4, 146, 240);
                                }
                                dateToday = date;
                                setState(() {});
                              },
                              leftMargin: 0,
                              dotsColor: colorDot,
                            ),
                          ))
                    ]),
            )),
      ),
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : Container(
              alignment: Alignment.center,
              child: SizedBox(
                //Box in the center
                width: 320,
                height: 270,
                child: Column(
                  children: [
                    //Picks a random qoute
                    Text(quotes[rnd].quote),
                    Text(quotes[rnd].author),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    1.0, 15.0, 1.0, 1.0),
                                child: Text(
                                  'Nächstes Training',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    1.0, 1.0, 1.0, 30.0),
                                child: Text(
                                  nextTraining,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 50),
                                  maximumSize: const Size(200, 50),
                                  primary: nextTraining !=
                                          'Kein Plan ausgewählt'
                                      ? const Color.fromARGB(1000, 0, 48, 80)
                                      : const Color.fromARGB(
                                          1000, 200, 200, 200),
                                ),
                                onPressed: () {
                                  nextTraining != 'Kein Plan ausgewählt'
                                      ? httpHelper
                                          .getNextTrainingDayId()
                                          .then((ids) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TrackingView(
                                                        trainingDayId: ids[0],
                                                        trainingPlanId: ids[1],
                                                      )));
                                        })
                                      : showInSnackbar(context,
                                          'Bitte erst Training auswählen.');
                                  ;
                                },
                                child: Text(
                                  'Training starten',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Anderen Tag auswählen',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            widget.onSelectTab(1);
                                          })),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void fetchData() async {
    //gets the trainingsdata of last week (when has the user trained)
    Trainweek trainweek = await httpHelper.getLastTrainday();
    String nextTrainingName = await httpHelper.getNextTrainingDayName();

    setState(() {
      fetching = false;
      trainigsDaten = trainweek;
      nextTraining = nextTrainingName;
    });
  }

  void showInSnackbar(BuildContext context, String value) {
    // Shows a message to the user
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }
}
