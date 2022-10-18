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
  const SecondQuestionWidget({super.key});

  @override
  _SecondQuestionWidget createState() => _SecondQuestionWidget();
}

class _SecondQuestionWidget extends State<SecondQuestionWidget> {
  late AccountHttpHelper account_http_helper;
  late Exercise exercise;
  late TextEditingController push_ups;

  @override
  void initState() {
    super.initState();

    account_http_helper = AccountHttpHelper();
    push_ups = TextEditingController();
  }

  String dropdownValue = "Ja";
  List<String> dropDownOptions = ["Ja", "Ein bisschen", "Nein"];
  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
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
            buildQuestion(text: 'Hast du bereits Erfahrung mit Training?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              dropDownOptions: dropDownOptions,
              dropDownValue: dropdownValue,
              dropdownCallback: dropdownCallback,
            ),
            const SizedBox(height: 16),
            buildQuestion(text: 'Wie viele Liegestützen schaffst du?'),
            AnswerFieldWidget(
              controller: push_ups,
            ),
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
                  Navigator.pushNamed(context, '/myProfile');
                })
          ],
        ),
      ),
    );
  }
}
