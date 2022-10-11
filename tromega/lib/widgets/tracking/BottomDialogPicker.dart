import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class BottomDialogPicker extends StatefulWidget {
  const BottomDialogPicker(
      {Key? key, required this.title, required this.startValue, required this.isDecimal, required this.onChangeValue, required this.stepSize})
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
    return Column(
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        widget.isDecimal
            ? DecimalNumberPicker(
                minValue: 0, 
                maxValue: 300, 
                value: value.toDouble(), 
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                  });
                  widget.onChangeValue(value);
                },
            )
            : NumberPicker(
                minValue: 0,
                maxValue: 50,
                step: widget.stepSize.toInt(),
                value: value.toInt(),
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                  });
                  widget.onChangeValue(value);
                },)
      ],
    );
  }
}
