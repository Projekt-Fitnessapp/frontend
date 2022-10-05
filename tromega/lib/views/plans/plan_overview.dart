import 'dart:ffi';
import '../../widgets/trainingsplanBtn.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';

class PlanOverview extends StatelessWidget {
  PlanOverview({Key? key}) : super(key: key);
  var secondTitle = 'Meine Trainingspläne';
  var createTrainingsplan = 'Neuen Trainingsplan erstellen';
  var createTrainingsplanChoice1 = 'Manuell erstellen';
  var createTrainingsplanChoice2 = 'Automatisch erstellen';
  var premium = false;
  var trainingsplanCnt = 3;
  var premiumDesc = 'Premium Inhalte freischalten';

  List<String> trainingsplanBtns = [
    'Trainingsplan 1',
    'Trainingsplan 2',
    'Trainingsplan 3',
    'Trainingsplan 4',
    'Trainingsplan 5'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hier Icon einfügen')),
      body: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                // ignore: prefer_const_constructors
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(secondTitle,
                      style: TextStyle(fontSize: 33, color: Colors.black)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton.extended(
                      extendedPadding: const EdgeInsetsDirectional.all(20.0),
                      label: Text(createTrainingsplan,
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              children: [
                                FloatingActionButton.extended(
                                  extendedPadding:
                                      const EdgeInsetsDirectional.all(20.0),
                                  label: Text(createTrainingsplanChoice1,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  backgroundColor: Colors.white,
                                  onPressed: () {},
                                ),
                                FloatingActionButton.extended(
                                  extendedPadding:
                                      const EdgeInsetsDirectional.all(20.0),
                                  label: Text(createTrainingsplanChoice2,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  backgroundColor: Colors.white,
                                  onPressed: () {},
                                )
                              ],
                            );
                          },
                        );
                      }),
                ),

                const SizedBox(
                  height: 70,
                ),
                Visibility(
                  visible: premium,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: trainingsplanBtns.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TrainingsplanBtn(name: trainingsplanBtns[index]);
                      }),
                ),

                Visibility(
                    visible: !premium,
                    child: Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: trainingsplanCnt,
                            itemBuilder: (BuildContext context, int index) {
                              return TrainingsplanBtn(
                                  name: trainingsplanBtns[index]);
                            }),
                        Stack(children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  trainingsplanBtns.length - trainingsplanCnt,
                              itemBuilder: (BuildContext context, int index) {
                                return TrainingsplanBtn(
                                  name: trainingsplanBtns[
                                      index + trainingsplanCnt],
                                );
                              }),
                          Container(
                            color: Color.fromARGB(255, 12, 12, 12)
                                .withOpacity(0.7),
                            height: 120,
                            width: 500,
                            child: Text(
                              premiumDesc,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          )
                        ])
                      ],
                    ))
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
