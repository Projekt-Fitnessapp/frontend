// Author: Matthias
import 'package:flutter/material.dart';
import '../interactives/value_picker.dart';

class DialogTimerPicker extends StatefulWidget {
  const DialogTimerPicker({Key? key, required this.onSubmit, required this.initialValue}) : super(key: key);

  final Function onSubmit;
  final dynamic initialValue;

  @override
  State<DialogTimerPicker> createState() => _DialogTimerPickerState();
}

class _DialogTimerPickerState extends State<DialogTimerPicker> {
  late int _currentTimerValue;

  @override
  void initState() {
    _currentTimerValue = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Pausenlänge (sek)",
              style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ValuePicker(
              type: ValueType.integer,
              minValue: 0,
              maxValue: 300,
              stepSize: 10,
              onChange: (newValue) => setState(() {
                _currentTimerValue = newValue;
              }),
              onSubmit: (newValue) => widget.onSubmit(newValue),
              initialValue: widget.initialValue,
            ),
          ),
          ElevatedButton(
              onPressed: () => widget.onSubmit(_currentTimerValue),
              child: Text("Übernehmen",
                  style: Theme.of(context).textTheme.labelMedium))
        ],
      ),
    ));
  }
}
