import 'package:tromega/views/plans/add_exercise.dart';
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
  FilterView({Key? key, required this.filter}) : super(key: key);
  Filter filter;

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  List<String> _selectedMuscle = [];
  List<String> _selectedEquipment = [];

  static final List<String> _muscleSelection = [
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
    "Gesäßmuskulatur",
  ];

  final _muscleItems = _muscleSelection
      .map((muscle) => MultiSelectItem<String>(muscle, muscle))
      .toList();

  static final List<String> _equipmentSelection = [
    "Machine",
    "Dumbbell",
    "Barbell",
    "Bodyweight",
    "Cable",
    "Kettlebell",
  ];

  final _equipmentItems = _equipmentSelection
      .map((equipment) => MultiSelectItem<String>(equipment, equipment))
      .toList();

  @override
  initState() {
    if (widget.filter.equipment.isEmpty && widget.filter.muscle.isEmpty) {
      _selectedMuscle = [];
      _selectedEquipment = [];
    } else {
      _selectedMuscle = widget.filter.muscle;
      _selectedEquipment = widget.filter.equipment;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Filter",
                style: Theme.of(context).textTheme.headlineMedium),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MultiSelectBottomSheetField(
                title: const Text("Equipment"),
                buttonText: const Text("Equipment auswählen"),
                items: _equipmentItems,
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  _selectedEquipment = values.map((e) => e.toString()).toList();
                },
                chipDisplay: MultiSelectChipDisplay(),
                initialValue: _selectedEquipment),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MultiSelectBottomSheetField(
                title: const Text("Muskel"),
                buttonText: const Text("Muskel auswählen"),
                items: _muscleItems,
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  setState(() {
                    _selectedMuscle = values.map((e) => e.toString()).toList();
                  });
                },
                chipDisplay: MultiSelectChipDisplay(),
                initialValue: _selectedMuscle),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ElevatedButton(
                        onPressed: () {
                          widget.filter.muscle = _selectedMuscle;
                          widget.filter.equipment = _selectedEquipment;
                          Navigator.pop(context, widget.filter);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Filter anwenden"),
                              Icon(Icons.check)
                            ])),
                  ),
                ),
                Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ElevatedButton(
                          onPressed: () {
                            widget.filter.muscle = [];
                            widget.filter.equipment = [];
                            Navigator.pop(context, widget.filter);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Filter zurücksetzen"),
                                Icon(Icons.restore)
                              ])),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
