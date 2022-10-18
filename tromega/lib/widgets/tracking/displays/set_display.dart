import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/displays/row_item.dart';
import 'package:tromega/widgets/tracking/interactives/changeable_row_item.dart';
import '../../../data/executionSet.dart';

class SetDisplay extends StatefulWidget {
  const SetDisplay({Key? key, required this.position, required this.thisSet, required this.highlighted, required this.onChange}) : super(key: key);
  final int position;
  final ExecutionSet thisSet;
  final Function onChange;
  final bool highlighted;

  @override
  State<SetDisplay> createState() => _SetDisplayState();
}

class _SetDisplayState extends State<SetDisplay> {
  late ExecutionSet thisSet;

  @override
  void initState() {
    thisSet = widget.thisSet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RowItem(
          value: (widget.position + 1).toString(),
          highlighted: widget.highlighted,
        ),
        ChangeableRowItem(
          value: thisSet.weight.toString(),
          displayFor: 'weight',
          highlighted: widget.highlighted,
          onChangeValue: (value) {
            setState(() {
              thisSet.weight = value;
            });
          },
        ),
        ChangeableRowItem(
          value: thisSet.reps.toString(),
          displayFor: 'reps',
          highlighted: widget.highlighted,
          onChangeValue: (value) {
            setState(() {
              thisSet.reps = value;
            });
          },
        ),
        RowItem(
          value: ((thisSet.weight * (36 / (37 - thisSet.reps))) * 0.7498).toStringAsFixed(1),
          highlighted: widget.highlighted,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: widget.highlighted ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            height: 40,
            child: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                widget.onChange();
              },
              icon: Icon(
                Icons.check_rounded,
                color: widget.highlighted
                    ? Theme.of(context).backgroundColor
                    : thisSet.done
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
