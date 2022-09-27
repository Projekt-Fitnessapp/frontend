import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';

class PlanDetailsView extends StatelessWidget {
  const PlanDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const secondTitle = 'Trainingsplan 1';
    const createTrainingsplan = 'Neuen Trainingsplan erstellen';
    List<String> workoutDays = ['Legs', 'Push', 'Pull', 'Push', 'Pull'];
    return Scaffold(
      appBar: AppBar(title: const Text('Hier Icon einfügen')),
      body: Column(
        children: [
          const SizedBox(
            width: 30,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: const Text(secondTitle,
                    style: TextStyle(fontSize: 33, color: Colors.black)),
              ),
              Container(
                child: Text('Aktiv'),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: workoutDays.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildTrainingsplanBtn(workoutDays[index]);
                        })
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
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
