import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/RowItem.dart';
import 'package:tromega/widgets/tracking/SetRow.dart';

import '../../data/executionSet.dart';

class SetDisplay extends StatefulWidget {
  const SetDisplay({Key? key, required this.executionSets, required this.onAddSet}) : super(key: key);
  final List<ExecutionSet> executionSets;
  final Function onAddSet;

  @override
  State<SetDisplay> createState() => _SetDisplayState();
}

class _SetDisplayState extends State<SetDisplay> {
  List<ExecutionSet> sets = [];

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
          children: sets
              .asMap()
              .entries
              .map((entry) => SetRow(
                  position: entry.key,
                  thisSet: entry.value,
                  highlighted: entry.key == getFirstToDo(),
                  onChange: () {
                    setState(() {
                      sets[entry.key].done = !entry.value.done;
                    });
                  }))
              .toList(),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              widget.onAddSet();
            },
            child: Text(
              'Satz hinzufügen',
              style: Theme.of(context).textTheme.labelLarge,
            ))
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

  int getFirstToDo() {
    return sets.indexWhere((elem) => elem.done == false);
  }
}
