import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/Dialogs/bottom_dialog_picker.dart';

class ChangeableRowItem extends StatefulWidget {
  const ChangeableRowItem(
      {Key? key,
      required this.value,
      required this.highlighted,
      required this.displayFor,
      required this.onChange})
      : super(key: key);
  final num value;
  final String displayFor;
  final bool highlighted;
  final Function onChange;

  @override
  State<ChangeableRowItem> createState() => _ChangeableRowItemState();
}

class _ChangeableRowItemState extends State<ChangeableRowItem> {
  late num currentValue;

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
                        ? Container()
                        : BottomDialogPicker(
                            title: widget.displayFor == 'reps'
                                ? 'Wiederholungen'
                                : 'Gewicht',
                            startValue: currentValue,
                            forReps: widget.displayFor == 'reps',
                            onSubmit: (value) {
                              setState(() {
                                currentValue = value;
                              });
                              widget.onChange(value);
                            },
                          );
                  },
                );
              },
              child: Text(
                currentValue.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )),
      ),
    );
  }
}
