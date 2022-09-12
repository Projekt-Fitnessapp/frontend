// Matthias

import 'package:flutter/material.dart';
import '../../data/exercise.dart';
import '../../data/set.dart';

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
    mockData = getMockData();
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

  List<Exercise> getMockData() {
    Set set1 = Set('1', 12, 40, 47.5);
    Set set2 = Set('2', 9, 65, 63.7);
    Set set3 = Set('3', 7, 65, 59.9);

    //Exercise e1 = Exercise('1', 'Bankdrücken', 'Beste Übung EUW', [set1, set2, set3]);
    //Exercise e2 = Exercise('2', 'Butterflys', 'Für die Milchtüten', [set1, set2, set3]);
    //Exercise e3 = Exercise('3', 'Trizeps Drücken', 'Willst du die Hufeisen, oder willst du sie nicht?', [set1, set2, set3]);
    //Exercise e4 = Exercise('4', 'Katana Extensions', 'Haaaayaaa der Samurai sein Vater', [set1, set2, set3]);

    return [];
  }
}
