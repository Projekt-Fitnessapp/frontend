import 'dart:ffi';
import '../../widgets/trainingsplanBtn.dart';
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
                          return TrainingsplanBtn(name: workoutDays[index]);
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
}
