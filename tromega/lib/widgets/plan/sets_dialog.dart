import 'package:flutter/material.dart';
import '../../data/classes.dart';
import 'package:numberpicker/numberpicker.dart';

class SetsDialog extends StatefulWidget {
  SetsDialog({Key? key, required this.sets, required this.changeSets})
      : super(key: key);
  int sets;
  final ValueChanged<int> changeSets;

  @override
  State<SetsDialog> createState() => _SetsDialogState();
}

class _SetsDialogState extends State<SetsDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          child: Text("${widget.sets} Sätze"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                          insetPadding: const EdgeInsets.all(150),
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: SizedBox(
                            width: double.minPositive,
                            child: NumberPicker(
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              minValue: 0,
                              maxValue: 10,
                              value: widget.sets,
                              onChanged: (int value) {
                                setState(() {});
                                super.setState(() {
                                  widget.sets = value;
                                  widget.changeSets(value);
                                });
                              },
                            ),
                          ));
                    }));
          },
        ));
  }
}
