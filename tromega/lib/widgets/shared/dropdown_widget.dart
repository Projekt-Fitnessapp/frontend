// Erstellt von Tobias Fitzke und Rebekka Miguez//

import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    super.key,
    required this.color,
    required this.items,
    required this.currentValue,
    required this.itemCallBack,
  });

  final Color color;
  List<String> items;
  String currentValue;
  ValueChanged<String> itemCallBack;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState(currentValue);
}

class _DropDownWidgetState extends State<DropDownWidget> {
  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentValue;

  _DropDownWidgetState(this.currentValue);

  @override
  initState() {
    super.initState();
    for (String item in widget.items) {
      dropDownItems.add(DropdownMenuItem(
          value: item,
          child: Text(
            item,
          )));
    }
  }

  @override
  void didUpdateWidget(DropDownWidget oldWidget) {
    if (currentValue != widget.currentValue) {
      setState(() {
        currentValue = widget.currentValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(bottom: 16),
        alignment: Alignment.centerLeft,
        child: (InputDecorator(
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: dropDownItems,
              value: currentValue,
              onChanged: (selectedItem) => setState(() {
                currentValue = selectedItem as String;
                widget.itemCallBack(currentValue);
              }),
              iconEnabledColor: widget.color,
              icon: const Icon(Icons.expand_more),
              isExpanded: true,
            ),
          ),
        )));
  }
}
