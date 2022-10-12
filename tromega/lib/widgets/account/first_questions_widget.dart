import 'package:flutter/material.dart';

import 'package:tromega/widgets/account/data_widget.dart';
import 'package:tromega/widgets/account/dropdown_widget.dart';
import 'package:tromega/widgets/account/routebutton_widget.dart';

class FirstQuestionWidget extends StatefulWidget {
  const FirstQuestionWidget({Key? key, this.title, required this.onClick})
      : super(key: key);

  final Function onClick;
  final String? title;

  @override
  _FirstQuestionWidget createState() => _FirstQuestionWidget();
}

class _FirstQuestionWidget extends State<FirstQuestionWidget> {
  late String value1 = "Muskeln aufbauen";
  late List<String> fitnessGoals = [
    "Muskeln aufbauen",
    "Ausdauer verbessern",
    "Gewicht verlieren"
  ];
  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        value1 = selectedValue;
      });
    }
  }

  late String value2 = "männlich";
  late List<String> gender = ["männlich", "weiblich", "divers"];
  void dropdownCallback2(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        value2 = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildQuestion(text: 'Wie alt bist du?'),
          buildTextField(color),
          buildQuestion(text: 'Wie groß bist du?'),
          buildTextField(color),
          buildQuestion(text: 'Wie viel wiegst du?'),
          buildTextField(color),
          buildQuestion(text: 'Was ist dein Trainingsziel?'),
          const SizedBox(height: 16),
          DropDownWidget(
            color: color,
            dropDownOptions: fitnessGoals,
            dropDownValue: value1,
            dropdownCallback: dropdownCallback,
          ),
          const SizedBox(height: 16),
          buildQuestion(text: 'Mit welchem Geschlecht identifizierst du dich?'),
          const SizedBox(height: 16),
          DropDownWidget(
            color: color,
            dropDownOptions: gender,
            dropDownValue: value2,
            dropdownCallback: dropdownCallback2,
          ),
          const SizedBox(height: 32),
          RouteButtonWidget(
              color: color, text: 'Weiter', onClick: widget.onClick),
        ],
      )),
    );
  }
}
