import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';

class PlanOverview extends StatelessWidget {
  const PlanOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const secondTitle = 'Meine Trainingspläne';
    const createTrainingsplan = 'Neuen Trainingsplan erstellen';
    const createTrainingsplanChoice1 = 'Manuell erstellen';
    const createTrainingsplanChoice2 = 'Automatisch erstellen';
    var premium = false;
    var trainingsplanCnt = 3;
    const premiumDesc = 'Premium Inhalte freischalten';

    List<String> trainingsplanBtns = [
      'Trainingsplan 1',
      'Trainingsplan 2',
      'Trainingsplan 3',
      'Trainingsplan 4',
      'Trainingsplan 5'
    ];
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
                  child: const Text(secondTitle,
                      style: TextStyle(fontSize: 33, color: Colors.black)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton.extended(
                      extendedPadding: const EdgeInsetsDirectional.all(20.0),
                      label: const Text(createTrainingsplan,
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
                                  label: const Text(createTrainingsplanChoice1,
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
                                  label: const Text(createTrainingsplanChoice2,
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
                        return buildTrainingsplanBtn(trainingsplanBtns[index]);
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
                              return buildTrainingsplanBtn(
                                  trainingsplanBtns[index]);
                            }),
                        Stack(children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  trainingsplanBtns.length - trainingsplanCnt,
                              itemBuilder: (BuildContext context, int index) {
                                return buildTrainingsplanBtn(trainingsplanBtns[
                                    index + trainingsplanCnt]);
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

  Widget buildTrainingsplanBtn(String name) => Column(
        children: [
          const SizedBox(height: 8.0),
          FloatingActionButton.extended(
            extendedPadding: const EdgeInsetsDirectional.all(50.0),
            label: Text(name,
                style: const TextStyle(fontSize: 33, color: Colors.black)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.white,
            onPressed: () {},
          ),
          const SizedBox(height: 8.0),
        ],
      );
}
