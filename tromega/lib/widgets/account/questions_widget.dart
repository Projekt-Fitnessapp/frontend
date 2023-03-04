import 'package:flutter/material.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/account_http_helper.dart';
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
  late Body thisBody;
  late Account thisAccount;

  @override
  void initState() {
    thisBody = Body("", "", DateTime.now(), 0, 0);
    thisAccount = Account("", "", "", DateTime.now(), "", "", List.empty());
    accountHttpHelper = AccountHttpHelper();
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
              controller: changedName,
              regExp: r'^[a-zA-Z ]+$',
            ),
            buildQuestion(text: 'Wie alt bist du?'),
            AnswerFieldWidget(
              controller: changedBirthday,
              regExp: r'^[\d-]+$',
            ),
            buildQuestion(text: 'Wie groß bist du?'),
            AnswerFieldWidget(
              controller: changedHeight,
              regExp: r'^[1-2]?[0-9]{1,2}',
            ),
            buildQuestion(text: 'Wie viel wiegst du?'),
            AnswerFieldWidget(
              controller: changedWeight,
              regExp: r'^[1-2]?[0-9]{1,2}',
            ),
            buildQuestion(text: 'Was ist dein Trainingsziel?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              items: trainingOptions,
              currentValue: trainingGoal,
              itemCallBack: (String trainingGoal) {
                this.trainingGoal = trainingGoal;
              },
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 32),
            buildQuestion(text: 'Hast du bereits Erfahrung mit Training?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              items: experienceOptions,
              currentValue: trainingExperience,
              itemCallBack: (String trainingExperience) {
                this.trainingExperience = trainingExperience;
              },
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
                  setState(() {
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
