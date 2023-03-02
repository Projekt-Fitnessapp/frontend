import 'package:tromega/views/plans/edit_training_view.dart';
import 'package:tromega/views/in_training/track_training_view.dart';

import '../../widgets/plan/exercise_container_plan.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/trainingDay.dart';
import 'package:tromega/data/filter.dart';
import 'package:tromega/data/trainingPlan.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class FilterView extends StatefulWidget {
  //Visualisierung von einem Tag eines Trainingsplans
  const FilterView({Key? key, required this.filter}) : super(key: key);
  final Filter filter;

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  final List<String> muscleSelection = [
    "Brust",
    "Bizeps",
    "Trizeps",
    "Schultern",
    "Rücken",
    "Latissimus",
    "Beinstrecker",
    "Beinbeuger",
    "Waden",
    "Bauchmuskulatur",
    "Gesäßmuskulatur"
  ];
  final List<String> equipmentSelection = [
    "Machine",
    "Dumbbell",
    "Barbell",
    "Bodyweight",
    "Cable"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: MultiSelectBottomSheet(
        items: equipmentSelection.map((e) => MultiSelectItem(e, e)).toList(),
        listType: MultiSelectListType.CHIP,
        onConfirm: (values) {
          widget.filter.equipment = [];
          for (var value in values) {
            widget.filter.equipment.add(value.toString());
          }
        },
        initialValue: widget.filter.equipment,
      ),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
