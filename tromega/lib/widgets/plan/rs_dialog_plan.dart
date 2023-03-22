// Author: Steffen
import 'package:flutter/material.dart';

class RSDialogPlan extends StatefulWidget {
  //Button für Sätze und Wiederholungen in der Plan Day View

  RSDialogPlan({Key? key, required this.number, required this.type})
      : super(key: key);
  int number;
  String type;

  @override
  State<RSDialogPlan> createState() => _RSDialogPlanState();
}

class _RSDialogPlanState extends State<RSDialogPlan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text("${widget.number} ${widget.type}"), onPressed: () {}));
  }
}
