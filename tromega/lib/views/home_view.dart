import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/bottom_menu.dart';
import 'social_space/social_space_view.dart';
import '../views/plans/plan_overview.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import '../../data/home_http_helper.dart';
import '../../data/trainday.dart';
import '../views/in_training/track_training_view.dart';
import '../views/plans/plan_overview.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, this.onSelectTab}) : super(key: key);
  final onSelectTab;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DateTime dateToday;
  late Color colorDot;
  late HomeHttpHelper homeHttpHelper;
  late Trainweek trainigsDaten;
  late String nextTraining;
  bool fetching = true;

  @override
  void initState() {
    homeHttpHelper = HomeHttpHelper();
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
                height: 190,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(1.0, 15.0, 1.0, 1.0),
                            child: Text(
                              'Nächstes Training',
                              style: Theme.of(context).textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 30.0),
                            child: Text(
                              nextTraining,
                              //style: Theme.of(context).textTheme.titleLarge,
                              //textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 50),
                              maximumSize: const Size(200, 50),
                              primary: nextTraining != 'Kein Plan ausgewählt'
                                  ? const Color.fromARGB(1000, 0, 48, 80)
                                  : const Color.fromARGB(1000, 200, 200, 200),
                            ),
                            onPressed: () {
                              nextTraining != 'Kein Plan ausgewählt'
                                  ? homeHttpHelper
                                      .getNextTrainingDayId()
                                      .then((trainingDayId) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrackingView(
                                                    trainingDayId:
                                                        trainingDayId,
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.onSelectTab(1);
                                      })),
                          )
                        ],
                      )),
                ),
              ),
            ),
    );
  }

  void fetchData() async {
    //gets the trainingsdata of last week (when has the user trained)
    Trainweek trainweek = await homeHttpHelper.getLastTrainday();
    String getNextTraining = await homeHttpHelper.getNextTrainingDayName();

    setState(() {
      print(getNextTraining);
      fetching = false;
      trainigsDaten = trainweek;
      nextTraining = getNextTraining;
    });
  }

  void showInSnackbar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }
}
