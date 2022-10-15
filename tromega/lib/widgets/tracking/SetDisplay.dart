import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/RowItem.dart';
import 'package:tromega/widgets/tracking/SetRow.dart';

import '../../data/executionSet.dart';

class SetDisplay extends StatefulWidget {
  const SetDisplay(
      {Key? key,
      required this.executionSets,
      required this.onAddSet,
      required this.onRemoveSet,
      required this.changeExecutionStatus,
      required this.onFinishExecution})
      : super(key: key);
  final List<ExecutionSet> executionSets;
  final Function onAddSet;
  final Function onRemoveSet;
  final Function changeExecutionStatus;
  final Function onFinishExecution;

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
              .map(
                (entry) => SetRow(
                  position: entry.key,
                  thisSet: entry.value,
                  highlighted: entry.key == getFirstToDo(),
                  onChange: () {
                    setState(() {
                      int firstToDo = getFirstToDo() == -1 ? sets.length : getFirstToDo();
                      if (entry.key + 1 == firstToDo || entry.key == firstToDo) {
                        sets[entry.key].done = !entry.value.done;
                      }
                      if (!sets[entry.key].done) {
                        widget.changeExecutionStatus(false);
                      }
                    });
                    if (getFirstToDo() == -1) {
                      widget.onFinishExecution();
                    }
                  },
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                  onPressed: () {
                    widget.onAddSet();
                  },
                  child: Text(
                    'Satz hinzufügen',
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                  onPressed: () {
                    widget.onRemoveSet();
                  },
                  child: Text(
                    'Satz entfernen',
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
            ),
          ],
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

  int getFirstToDo() {
    return sets.indexWhere((elem) => elem.done == false);
  }
}
