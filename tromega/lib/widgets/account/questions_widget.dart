import 'package:flutter/material.dart';
import 'package:tromega/data/classes/account.dart';
import 'package:tromega/data/http_helper.dart';
import 'package:tromega/data/classes/body.dart';
import 'package:tromega/widgets/account/answer_field_widget.dart';
import 'package:tromega/widgets/account/data_widget.dart';
import 'package:tromega/widgets/account/dropdown_widget.dart';
import 'package:tromega/widgets/account/routebutton_widget.dart';
import 'package:intl/intl.dart';

//Erstellt von Rebekka Miguez//

class QuestionWidget extends StatefulWidget {
  //Die Widget zur Eintragung der einzelnen Profil Daten
  const QuestionWidget({Key? key, required this.onFinished}) : super(key: key);

  final Function onFinished;

  @override
  _SecondQuestionWidget createState() => _SecondQuestionWidget();
}

class _SecondQuestionWidget extends State<QuestionWidget> {
  late HttpHelper httpHelper;
  late TextEditingController changedBirthday;
  late TextEditingController changedName;
  late TextEditingController changedHeight;
  late TextEditingController changedWeight;
  late Body thisBody;
  late Account thisAccount;

  @override
  void initState() {
    thisBody = Body("", "", DateTime.now(), 0, 0);
    thisAccount = Account("", "", "", DateTime.now(), "", "", List.empty());
    httpHelper = const HttpHelper();
    changedBirthday = TextEditingController();
    changedName = TextEditingController();
    changedHeight = TextEditingController();
    changedWeight = TextEditingController();
    super.initState();
  }

  String trainingExperience = "Ja";
  List<String> experienceOptions = ["Ja", "Ein bisschen", "Nein"];

  String trainingGoal = "Muskeln aufbauen";
  late List<String> trainingOptions = [
    "Muskeln aufbauen",
    "Ausdauer verbessern",
    "Gewicht verlieren"
  ];

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
            buildTextField(color),
            buildQuestion(text: 'Wie viele Klimmzüge schaffst du?'),
            buildTextField(color),
            buildQuestion(text: 'Wie viele Kniebeugen schaffst du?'),
            buildTextField(color),
            buildQuestion(text: 'Wie viele Crunches schaffst du?'),
            buildTextField(color),
            RouteButtonWidget(
                color: color,
                text: 'Registrieren',
                onClick: () {
                  setState(() {
                    //Speicherung der aktuellen Eingabedaten
                    thisBody.height = int.parse(changedHeight.text);
                    thisBody.weight = int.parse(changedWeight.text);
                    thisAccount.birthdate = format.parse(changedBirthday.text);
                    thisAccount.name = changedName.text;
                    thisAccount.sex = gender;
                  });
                  widget.onFinished(thisAccount, thisBody);
                })
          ],
        ),
      ),
    );
  }
}
