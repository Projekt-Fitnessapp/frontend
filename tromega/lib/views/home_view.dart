import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tromega/views/traindayview.dart';
import '../widgets/bottom_menu.dart';
import '../views/social_space_view.dart';
import '../views/plans/plan_overview.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DateTime dateToday;
  late Color colorDot;

  @override
  void initState() {
    dateToday = DateTime.now();
    colorDot = Color.fromARGB(1000, 4, 146, 240);
    super.initState();
  }

  var trainigsDaten = Trainweek("week", [
    Trainday(DateTime.now().subtract(const Duration(days: 1)), true),
    Trainday(DateTime.now().subtract(const Duration(days: 2)), false),
    Trainday(DateTime.now().subtract(const Duration(days: 3)), true),
    Trainday(DateTime.now().subtract(const Duration(days: 4)), false),
    Trainday(DateTime.now().subtract(const Duration(days: 5)), false),
    Trainday(DateTime.now().subtract(const Duration(days: 6)), false),
    Trainday(DateTime.now().subtract(const Duration(days: 7)), true)
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1000, 0, 48, 80),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(152.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CalendarTimeline(
                        initialDate: dateToday,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 7)),
                        lastDate: DateTime.now().add(const Duration(days: 7)),
                        dayColor: Colors.black,
                        activeBackgroundDayColor: Color.fromARGB(
                            1000, 4, 146, 240), //rgba(4,146,240,1.000)
                        onDateSelected: (date) {
                          var daysBack = DateTime.now().day - date.day;
                          if (daysBack > 0) {
                            if (trainigsDaten.days[daysBack - 1].trained) {
                              colorDot = Color.fromARGB(1000, 240, 157, 2);
                            } else {
                              colorDot = Color.fromARGB(1000, 4, 146, 240);
                            }
                          } else {
                            colorDot = Color.fromARGB(1000, 4, 146, 240);
                          }
                          dateToday = date;
                          //DateTime myDate = DateTime.parse('2022-09-15 00:00:00Z');
                          //if (date.year == myDate.year &&
                          //date.month == myDate.month &&
                          //date.day == myDate.day) {
                          //prüfen ob selectedDate in json true hat
                          //colorDot = Colors.amber;
                          //}
                          setState(() {});
                        },
                        leftMargin: 0,
                        dotsColor: colorDot,
                      ),
                    ))
              ]),
            )),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
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
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(1.0, 15.0, 1.0, 1.0),
                      child: Text(
                        'Nächstes Training',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 30.0),
                      child: Text(
                        'Legs',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Raleway'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                        primary: Color.fromARGB(1000, 0, 48, 80),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SocialSpaceView()));
                      },
                      child: const Text(
                        'Training starten',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: RichText(
                          text: TextSpan(
                              text: 'Anderen Tag auswählen',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Raleway'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlanOverview()));
                                })),
                    )
                  ],
                )),
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(index: 0),
    );
  }
}
