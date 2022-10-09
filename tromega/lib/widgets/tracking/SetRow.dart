import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/RowItem.dart';
import '../../data/exerciseSet.dart';

class SetRow extends StatefulWidget {
  const SetRow({Key? key, required this.position, required this.thisSet}) : super(key: key);
  final int position;
  final ExerciseSet thisSet;

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RowItem(value: widget.position.toString(), highlighted: false),
        RowItem(value: widget.thisSet.reps.toString(), highlighted: false),
        RowItem(value: widget.thisSet.weight.toString(), highlighted: false),
        RowItem(value: widget.thisSet.tenRM.toString(), highlighted: false),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check),
            ),
          ),
        ),
      ],
    );
  }
}
