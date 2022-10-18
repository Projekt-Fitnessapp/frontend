import 'package:flutter/material.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/data/classes.dart';
import 'package:tromega/widgets/account/answer_field_widget.dart';
import 'package:tromega/widgets/account/data_widget.dart';
import 'package:tromega/widgets/account/dropdown_widget.dart';
import 'package:tromega/widgets/account/routebutton_widget.dart';

class SecondQuestionWidget extends StatefulWidget {
  const SecondQuestionWidget({Key? key, required this.onFinished})
      : super(key: key);

  final Function onFinished;

  @override
  _SecondQuestionWidget createState() => _SecondQuestionWidget();
}

class _SecondQuestionWidget extends State<SecondQuestionWidget> {
  late AccountHttpHelper account_http_helper;
  late TextEditingController height;

  @override
  void initState() {
    super.initState();

    account_http_helper = AccountHttpHelper();
    height = TextEditingController();
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
          AnswerFieldWidget(controller: height),
          buildQuestion(text: 'Wie viel wiegst du?'),
          buildTextField(color),
          buildQuestion(text: 'Was ist dein Trainingsziel?'),
          const SizedBox(height: 16),
          DropDownWidget(
            color: color,
            dropDownOptions: fitnessGoals,
            dropDownValue: value1,
            dropdownCallback: dropdownCallback3,
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
            buildQuestion(text: 'Hast du bereits Erfahrung mit Training?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              dropDownOptions: dropDownOptions,
              dropDownValue: dropdownValue,
              dropdownCallback: dropdownCallback3,
            ),
            const SizedBox(height: 16),
            buildQuestion(text: 'Wie viele Liegestützen schaffst du?'),
            buildTextField(color),
            buildQuestion(text: 'Wie viele Klimmzüge schaffst du?'),
            buildTextField(color),
            buildQuestion(text: 'Wie viel Kilo stemmst du?'),
            buildTextField(color),
            buildQuestion(text: 'Wie häufig gehst du trainieren?'),
            buildTextField(color),
            RouteButtonWidget(
                color: color,
                text: 'Registrieren',
                onClick: () {
                  widget.onFinished();
                  Navigator.pushNamed(context, '/myProfile');
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
