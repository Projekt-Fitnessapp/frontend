import 'package:flutter/material.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/data/userAccount.dart';

import 'package:tromega/widgets/account/dropdown_widget.dart';
import 'package:tromega/widgets/account/routebutton_widget.dart';

class FirstQuestionWidget extends StatefulWidget {
  FirstQuestionWidget({Key? key, required this.onClick}) : super(key: key);

  final Function onClick;
  late AccountHttpHelper accountHttpHelper;

  @override
  _FirstQuestionWidget createState() => _FirstQuestionWidget();

  onInit() {
    accountHttpHelper = AccountHttpHelper();
  }
}

class _FirstQuestionWidget extends State<FirstQuestionWidget> {
  late TextEditingController controller;
  late UserAccount userAccount;
  late Body body;

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

  Widget buildQuestion({required String text}) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      );

  Widget buildTextField(Color color) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          controller: controller,
          style: const TextStyle(height: 0.5),
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.unfold_more),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey))),
        ),
      );
}
