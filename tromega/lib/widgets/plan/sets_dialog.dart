import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class SetsDialog extends StatefulWidget {
  //Dialog und Button für die Auswahl der Wiederholungen in der Edit Training View

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
            //Dialog mit NumberPicker
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
                              minValue: 1,
                              maxValue: 10,
                              value: widget.sets,
                              onChanged: (int value) {
                                //Aktualisierung der Satzanzahl im trainingsplan
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
