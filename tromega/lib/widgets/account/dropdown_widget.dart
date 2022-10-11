import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget(
      {super.key,
      required this.color,
      required this.dropDownOptions,
      required this.dropDownValue,
      required this.dropdownCallback});

  final Color color;
  final List<String> dropDownOptions;
  final String dropDownValue;
  final  dropdownCallback;

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
              items: dropDownOptions
                  .map<DropdownMenuItem<String>>((String mascot) {
                return DropdownMenuItem<String>(
                    value: mascot, child: Text(mascot));
              }).toList(),
              value: dropDownValue,
              onChanged: dropdownCallback,
              iconEnabledColor: color,
              icon: const Icon(Icons.expand_more),
              isExpanded: true,
            ),
          ),
        )));
  }
}
