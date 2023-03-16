import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/Dialogs/bottom_dialog_picker.dart';

class PushDialog extends StatefulWidget {
  PushDialog({Key? key, required this.pushUps, required this.changePushUps})
      : super(key: key);
  
  int pushUps;
  final ValueChanged<int> changePushUps;
  @override
  State<PushDialog> createState() => _PushDialogState();
}

class _PushDialogState extends State<PushDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          child: Text("${widget.pushUps} Liegestützen"),
          onPressed: () {
            //Dialog mit Number Picker
            showModalBottomSheet(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                      return BottomDialogPicker(
                          title: "Liegestützen",
                          forReps: true,
                          startValue: widget.pushUps,
                          onSubmit: (int value) {
                            //Aktualisierung der Satzanzahl im Trainingsplan
                            setState(() {});
                            super.setState(() {
                              widget.pushUps = value;
                              widget.changePushUps(value);
                            });
                          });
                    }));
          },
        ));
  }
}