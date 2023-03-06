import 'package:flutter/material.dart';
import '../interactives/value_picker.dart';

class DialogTimerPicker extends StatelessWidget {
  const DialogTimerPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Timer einstellen",
              style: Theme.of(context).textTheme.headlineMedium),
          const ValuePicker(
            type: ValueType.integer,
            minValue: 0,
            maxValue: 300,
            stepSize: 10,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text("Übernehmen",
                  style: Theme.of(context).textTheme.labelMedium))
        ],
      ),
    ));
  }
}
