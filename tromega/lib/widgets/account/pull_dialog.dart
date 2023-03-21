import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/Dialogs/bottom_dialog_picker.dart';

class PullDialog extends StatefulWidget {
  PullDialog({Key? key, required this.pullUps, required this.changePullUps})
      : super(key: key);

  int pullUps;
  final ValueChanged<int> changePullUps;
  @override
  State<PullDialog> createState() => _PullDialogState();
}

class _PullDialogState extends State<PullDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          child: Text("${widget.pullUps} Klimmzüge"),
          onPressed: () {
            //Dialog mit Number Picker
            showModalBottomSheet(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                      return BottomDialogPicker(
                          maxValue: 200,
                          title: "Klimmzüge",
                          forReps: true,
                          startValue: widget.pullUps,
                          onSubmit: (int value) {
                            //Aktualisierung der Satzanzahl im Trainingsplan
                            setState(() {});
                            super.setState(() {
                              widget.pullUps = value;
                              widget.changePullUps(value);
                            });
                          });
                    }));
          },
        ));
  }
}
