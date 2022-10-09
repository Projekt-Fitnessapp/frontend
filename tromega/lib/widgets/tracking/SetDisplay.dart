import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/RowItem.dart';
import 'package:tromega/widgets/tracking/SetRow.dart';

import '../../data/exerciseSet.dart';

class SetDisplay extends StatefulWidget {
  const SetDisplay({Key? key, required this.executionSets}) : super(key: key);
  final List<ExerciseSet> executionSets;

  @override
  State<SetDisplay> createState() => _SetDisplayState();
}

class _SetDisplayState extends State<SetDisplay> {
  List<ExerciseSet> sets = [];

  @override
  void initState() {
    sets = widget.executionSets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SetTableHead(),
        Column(
          children: sets.asMap().entries.map((entry) => SetRow(position: entry.key, thisSet: entry.value)).toList(),
        )
      ],
    );
  }

  Widget SetTableHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        RowItem(value: 'Satz', highlighted: false),
        RowItem(value: 'KG', highlighted: false),
        RowItem(value: 'WDH', highlighted: false),
        RowItem(value: '10RM', highlighted: false),
        RowItem(value: '', highlighted: false),
      ],
    );
  }
}
