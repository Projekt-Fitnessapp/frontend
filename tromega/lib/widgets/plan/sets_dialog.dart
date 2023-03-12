import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/Dialogs/bottom_dialog_picker.dart';

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
            showModalBottomSheet(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                      return BottomDialogPicker(
                        title: "Sätze",
                        forReps: true,
                        startValue: widget.sets,
                        onSubmit: (int value) {
                          //Aktualisierung der Satzanzahl im trainingsplan
                          setState(() {});
                          super.setState(() {
                            widget.sets = value;
                            widget.changeSets(value);
                          });
                        },
                      );
                    }));
          },
        ));
  }
}
