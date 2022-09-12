import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_menu.dart';
import '../views/social_space_view.dart';
import '../views/plans/plan_overview.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Column(children: [
            Container(
              height: 120,
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
              child: CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 7)),
                lastDate: DateTime.now().add(const Duration(days: 7)),
                onDateSelected: (date) {
                  print(date);
                },
                leftMargin: MediaQuery.of(context).size.width / 6,
                dotsColor: Colors.amber,
              ),
            )
          ]),
        ),
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
                                              const PlanOverview()));
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
