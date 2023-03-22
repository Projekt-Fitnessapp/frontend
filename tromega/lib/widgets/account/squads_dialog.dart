import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/Dialogs/bottom_dialog_picker.dart';

// Erstellt von Rebekka Miguez //

class SquadsDialog extends StatefulWidget {
  //Dialog zur Eingabe der Kniebeugen
  SquadsDialog({Key? key, required this.squads, required this.changeSquads})
      : super(key: key);

  int squads;
  final ValueChanged<int> changeSquads;
  @override
  State<SquadsDialog> createState() => _SquadsDialogState();
}

class _SquadsDialogState extends State<SquadsDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          child: Text("${widget.squads} Kniebeugen"),
          onPressed: () {
            //Dialog mit Number Picker
            showModalBottomSheet(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                      return BottomDialogPicker(
                          maxValue: 200,
                          title: "Kniebeugen",
                          forReps: true,
                          startValue: widget.squads,
                          onSubmit: (int value) {
                            //Aktualisierung der Satzanzahl im Trainingsplan
                            setState(() {});
                            super.setState(() {
                              widget.squads = value;
                              widget.changeSquads(value);
                            });
                          });
                    }));
          },
        ));
  }
}
