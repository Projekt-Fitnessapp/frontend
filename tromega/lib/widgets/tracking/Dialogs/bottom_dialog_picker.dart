import 'package:flutter/material.dart';
import '../interactives/value_picker.dart';

class BottomDialogPicker extends StatefulWidget {
  const BottomDialogPicker({
    Key? key,
    required this.title,
    required this.onSubmit,
    required this.forReps,
    required this.startValue,
  }) : super(key: key);
  final String title;
  final Function onSubmit;
  final bool forReps;
  final num startValue;

  @override
  State<BottomDialogPicker> createState() => _BottomDialogPickerState();
}

class _BottomDialogPickerState extends State<BottomDialogPicker> {
  late num value;

  @override
  void initState() {
    value = widget.startValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          widget.forReps ? buildRepetitionPicker() : buildWeightPicker(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Abbrechen',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onSubmit(value);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Übernehmen',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRepetitionPicker() {
    return ValuePicker(
      minValue: 0,
      maxValue: 25,
      stepSize: 1,
      onChange: (newValue) => value = newValue,
      onSubmit: (newValue) {
        widget.onSubmit(newValue);
        Navigator.pop(context);
      },
      initialValue: value.toInt(),
    );
  }

  Widget buildWeightPicker() {
    return ValuePicker(
      minValue: 0,
      maxValue: 300,
      stepSize: 2.5,
      initialValue: value,
      onChange: (newValue) => value = newValue,
      onSubmit: (newValue) {
        widget.onSubmit(newValue);
        Navigator.pop(context);
      },
    );
  }

  Widget buildExecutionTypePicker() {
    return const Text('');
  }
}
