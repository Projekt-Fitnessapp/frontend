//Erstellt von Rebekka Miguez//

import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/Dialogs/bottom_dialog_picker.dart';

class CrunchesDialog extends StatefulWidget {
  //Dialog zur Eingabe der Crunches
  CrunchesDialog(
      {Key? key, required this.crunches, required this.changeCrunches})
      : super(key: key);

  int crunches;
  final ValueChanged<int> changeCrunches;
  @override
  State<CrunchesDialog> createState() => _CrunchesDialogState();
}

class _CrunchesDialogState extends State<CrunchesDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          child: Text("${widget.crunches} Crunches"),
          onPressed: () {
            //Dialog mit Number Picker
            showModalBottomSheet(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                      return BottomDialogPicker(
                          maxValue: 200,
                          title: "Crunches",
                          forReps: true,
                          startValue: widget.crunches,
                          onSubmit: (int value) {
                            //Aktualisierung der Anzahl der Crunches
                            setState(() {});
                            super.setState(() {
                              widget.crunches = value;
                              widget.changeCrunches(value);
                            });
                          });
                    }));
          },
        ));
  }
}
