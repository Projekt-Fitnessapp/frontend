import 'package:flutter/material.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/data/benchmarking.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/widgets/account/answer_field_widget.dart';
import 'package:tromega/widgets/account/data_widget.dart';
import 'package:tromega/widgets/account/dropdown_widget.dart';
import 'package:tromega/widgets/account/routebutton_widget.dart';
import 'package:intl/intl.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.onFinished}) : super(key: key);

  final Function onFinished;

  @override
  _SecondQuestionWidget createState() => _SecondQuestionWidget();
}

class _SecondQuestionWidget extends State<QuestionWidget> {
  late AccountHttpHelper accountHttpHelper;
  late TextEditingController changedBirthday;
  late TextEditingController changedName;
  late TextEditingController changedHeight;
  late TextEditingController changedWeight;
  late TextEditingController push_ups;
  late TextEditingController pull_ups;
  late TextEditingController crunches;
  late TextEditingController squads;
  late Body thisBody;
  late Account thisAccount;
  late Benchmarking thisPushUps;
  late Benchmarking thisPullUps;
  late Benchmarking thisSquads;
  late Benchmarking thisCrunches;

  @override
  void initState() {
    thisBody = Body("", "", DateTime.now(), 0, 0);
    thisAccount = Account("", "", "", DateTime.now(), "", "", List.empty());
    thisPushUps = Benchmarking("", "", "", 0, 0);
    thisPullUps = Benchmarking("", "", "", 0, 0);
    thisSquads = Benchmarking("", "", "", 0, 0);
    thisCrunches = Benchmarking("", "", "", 0, 0);
    accountHttpHelper = AccountHttpHelper();
    changedBirthday = TextEditingController();
    changedName = TextEditingController();
    changedHeight = TextEditingController();
    changedWeight = TextEditingController();
    push_ups = TextEditingController();
    pull_ups = TextEditingController();
    crunches = TextEditingController();
    squads = TextEditingController();
    super.initState();
  }

  late String gender = "male";
  late List<String> genderOptions = ["male", "female"];

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    final color = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildQuestion(text: 'Wie heißt du?'),
            AnswerFieldWidget(
              maxLength: 30,
              controller: changedName,
              hintText: "Vorname Nachname",
              suffixText: "",
              regExp: r'[A-Za-zÄÖÜäöüß ]',
            ),
            buildQuestion(text: 'Wann hast du Geburtstag?'),
            AnswerFieldWidget(
              maxLength: 10,
              controller: changedBirthday,
              hintText: "YYYY-MM-DD",
              suffixText: "",
              regExp: r'[0-9-]',
            ),
            buildQuestion(text: 'Wie groß bist du?'),
            AnswerFieldWidget(
              maxLength: 3,
              controller: changedHeight,
              hintText: "0",
              suffixText: "cm",
              regExp: r'^[1-2]?[0-9]{1,2}',
            ),
            buildQuestion(text: 'Wie viel wiegst du?'),
            AnswerFieldWidget(
              maxLength: 3,
              controller: changedWeight,
              hintText: "0",
              suffixText: "kg",
              regExp: r'^[1-2]?[0-9]{1,2}',
            ),
            buildQuestion(
                text: 'Mit welchem Geschlecht identifizierst du dich?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              items: genderOptions,
              currentValue: gender,
              itemCallBack: (String gender) {
                this.gender = gender;
              },
            ),
            const SizedBox(height: 16),
            buildQuestion(text: 'Wie viele Liegestützen schaffst du?'),
            AnswerFieldWidget(
                maxLength: 3,
                hintText: "0",
                suffixText: "",
                controller: push_ups,
                regExp: '[0-9]'),
            buildQuestion(text: 'Wie viele Klimmzüge schaffst du?'),
            AnswerFieldWidget(
                maxLength: 3,
                hintText: "0",
                suffixText: "",
                controller: pull_ups,
                regExp: '[0-9]'),
            buildQuestion(text: 'Wie viele Kniebeugen schaffst du?'),
            AnswerFieldWidget(
                maxLength: 3,
                hintText: "0",
                suffixText: "",
                controller: squads,
                regExp: '[0-9]'),
            buildQuestion(text: 'Wie viele Crunches schaffst du?'),
            AnswerFieldWidget(
                maxLength: 3,
                hintText: "0",
                suffixText: "",
                controller: crunches,
                regExp: '[0-9]'),
            RouteButtonWidget(
                color: color,
                text: 'Registrieren',
                onClick: () {
                  setState(() {
                    thisBody.height = int.parse(changedHeight.text);
                    thisBody.weight = int.parse(changedWeight.text);
                    thisAccount.birthdate = format.parse(changedBirthday.text);
                    thisAccount.name = changedName.text;
                    thisAccount.sex = gender;
                    thisPushUps.exercise_amount = int.parse(push_ups.text);
                    thisPushUps.exercise_name = "push_ups";
                    thisPullUps.exercise_amount =
                        int.parse(pull_ups.text);
                    thisPullUps.exercise_name = "pull_ups";
                    thisSquads.exercise_amount = int.parse(squads.text);
                    thisSquads.exercise_name = "squads";
                    thisCrunches.exercise_amount =
                        int.parse(crunches.text);
                    thisCrunches.exercise_name = "crunches";
                  });
                  widget.onFinished(thisAccount, thisBody, thisPushUps, thisPullUps, thisSquads, thisCrunches);
                })
          ],
        ),
      ),
    );
  }
}
