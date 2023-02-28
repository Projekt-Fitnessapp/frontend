import 'package:flutter/material.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/generate_plan_http_helper.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/widgets/account/answer_field_widget.dart';
import 'package:tromega/widgets/account/data_widget.dart';
import 'package:tromega/widgets/account/dropdown_widget.dart';
import 'package:tromega/widgets/account/routebutton_widget.dart';

class GeneratePlanQuestionWidget extends StatefulWidget {
  const GeneratePlanQuestionWidget({Key? key, required this.onFinished})
      : super(key: key);

  final Function onFinished;

  @override
  _SecondGeneratePlanQuestionWidget createState() =>
      _SecondGeneratePlanQuestionWidget();
}

class _SecondGeneratePlanQuestionWidget
    extends State<GeneratePlanQuestionWidget> {
  late GeneratePlanHttpHelper generatePlanHttpHelper;
  late TextEditingController changedName;
  late TextEditingController changedHeight;
  late TextEditingController changedWeight;
  late Body thisBody;
  late Account thisAccount;

  @override
  void initState() {
    thisBody = Body("", "", DateTime.now(), 0, 0);
    generatePlanHttpHelper = GeneratePlanHttpHelper();
    changedName = TextEditingController();
    changedHeight = TextEditingController();
    changedWeight = TextEditingController();
    super.initState();
  }

  String dropdownValue = "Ja";
  List<String> dropDownOptions = ["Ja", "Ein bisschen", "Nein"];
  void dropdownCallback3(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }

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

  late String value2 = "male";
  late List<String> gender = ["male", "female"];
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
            buildQuestion(text: 'Wie oft willst du trainieren?'),
            buildTextField(color),
            buildQuestion(text: 'Wie alt bist du?'),
            buildTextField(color),
            buildQuestion(text: 'Wie groß bist du?'),
            AnswerFieldWidget(controller: changedHeight),
            buildQuestion(text: 'Wie viel wiegst du?'),
            AnswerFieldWidget(controller: changedWeight),
            buildQuestion(text: 'Was ist dein Trainingsziel?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              dropDownOptions: fitnessGoals,
              dropDownValue: value1,
              dropdownCallback: dropdownCallback3,
            ),
            const SizedBox(height: 16),
            buildQuestion(
                text: 'Mit welchem Geschlecht identifizierst du dich?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              dropDownOptions: gender,
              dropDownValue: value2,
              dropdownCallback: dropdownCallback2,
            ),
            RouteButtonWidget(
                color: color,
                text: 'Plan generieren',
                onClick: () {
                  setState(() {
                    thisBody.height = int.parse(changedHeight.text);
                    thisBody.weight = int.parse(changedWeight.text);
                    thisAccount.name = changedName.text;
                    thisAccount.sex = value2;
                  });
                  widget.onFinished(thisBody);
                })
          ],
        ),
      ),
    );
  }
}
