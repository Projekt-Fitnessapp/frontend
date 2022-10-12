import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/BottomDialogPicker.dart';
import 'package:tromega/widgets/tracking/BottomDialogTypePicker.dart';

class ChangeableRowItem extends StatefulWidget {
  const ChangeableRowItem(
      {Key? key,
      required this.value,
      required this.highlighted,
      required this.displayFor,
      required this.onChangeValue})
      : super(key: key);
  final String value;
  final String displayFor;
  final bool highlighted;
  final Function onChangeValue;

  @override
  State<ChangeableRowItem> createState() => _ChangeableRowItemState();
}

class _ChangeableRowItemState extends State<ChangeableRowItem> {
  late String currentValue;

  @override
  void initState() {
    currentValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: widget.highlighted
            ? Theme.of(context).highlightColor
            : Theme.of(context).backgroundColor,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.15,
        height: 40,
        child: Align(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return widget.displayFor == 'type'
                        ? BottomDialogTypePicker()
                        : BottomDialogPicker(
                            title: widget.displayFor == 'reps'
                                ? 'Wiederholungen'
                                : 'Gewicht',
                            isDecimal:
                                widget.displayFor == 'reps' ? false : true,
                            startValue: widget.displayFor == 'reps'
                                ? int.parse(currentValue)
                                : double.parse(currentValue),
                            stepSize: 1,
                            onChangeValue: (value) {
                              setState(() {
                                currentValue = value.toString();
                              });
                              widget.onChangeValue(value);
                            },
                          );
                  },
                );
              },
              child: Text(
                currentValue,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )),
      ),
    );
  }
}
