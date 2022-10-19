import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.color,
    required this.dropDownOptions,
    required this.dropDownValue,
    required this.dropdownCallback,
  });

  final Color color;
  final List<String> dropDownOptions;
  final String dropDownValue;
  final Function dropdownCallback;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late String value;

  @override
  initState() {
    value = widget.dropDownValue;
    super.initState();
  }

  changeValue(changedValue) {
    setState(() {
      value = changedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        child: (InputDecorator(
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: widget.dropDownOptions
                  .map<DropdownMenuItem<String>>((String mascot) {
                return DropdownMenuItem<String>(
                    value: mascot, child: Text(mascot));
              }).toList(),
              value: widget.dropDownValue,
              onChanged: ((String? changedValue) {
                changeValue(changedValue);
              }),
              iconEnabledColor: widget.color,
              icon: const Icon(Icons.expand_more),
              isExpanded: true,
            ),
          ),
        )));
  }
}
