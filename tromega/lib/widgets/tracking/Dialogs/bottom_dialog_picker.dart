import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class BottomDialogPicker extends StatefulWidget {
  const BottomDialogPicker(
      {Key? key,
      required this.title,
      required this.startValue,
      required this.isDecimal,
      required this.onChangeValue,
      required this.stepSize})
      : super(key: key);
  final String title;
  final num startValue;
  final bool isDecimal;
  final Function onChangeValue;
  final num stepSize;

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
          widget.isDecimal ? buildWeightPicker() : buildRepetitionPicker(),
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
                      widget.onChangeValue(value);
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
    return NumberPicker(
      minValue: 0,
      maxValue: 50,
      step: widget.stepSize.toInt(),
      value: value.toInt(),
      onChanged: (newValue) {
        setState(() {
          value = newValue;
        });
      },
    );
  }

  Widget buildWeightPicker() {
    return DecimalNumberPicker(
      minValue: 0,
      maxValue: 300,
      value: value.toDouble(),
      onChanged: (newValue) {
        setState(() {
          value = newValue;
        });
      },
    );
  }

  Widget buildExecutionTypePicker() {
    return const Text('');
  }
}
