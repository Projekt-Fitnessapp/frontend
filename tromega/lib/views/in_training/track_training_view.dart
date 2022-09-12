// Matthias

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/exercise.dart';
import '../../data/exerciseUnit.dart';
import '../../data/trainingUnit.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({Key? key}) : super(key: key);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  // later from api request
  late List<Exercise> mockData;

  @override
  initState() {
    getMockData();
    mockData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hier Icon einfügen')),
        body: PageView.builder(
            itemCount: mockData.length,
            itemBuilder: (BuildContext context, int index) {
              return TrackExercise(mockData[index]);
            }));
  }

  Widget TrackExercise(Exercise e) {
    return Text(e.name);
  }

  Future<List<Exercise>> getMockData() async {
    String response1 = await rootBundle.loadString('lib/views/in_training/testExercise.json');
    String response2 = await rootBundle.loadString('lib/views/in_training/testExerciseUnit.json');
    String response3 = await rootBundle.loadString('lib/views/in_training/testTrainingsUnit.json');
    dynamic data1 = json.decode(response1);
    dynamic data2 = json.decode(response2);
    dynamic data3 = json.decode(response3);

    TrainingUnit unit = TrainingUnit.fromJSON(data3);

    print(unit);

    //print('data:');
    //print(data);
    //print('Ende');

    return [];
  }
}
