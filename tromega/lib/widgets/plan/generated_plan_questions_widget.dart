import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/generatedPlanPreferences.dart';
import 'package:tromega/widgets/shared/data_widget.dart';
import 'package:tromega/widgets/shared/dropdown_widget.dart';
import 'package:tromega/widgets/shared/routebutton_widget.dart';

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
  late GeneratedPlanPreferences preferences;

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";

    preferences = GeneratedPlanPreferences(userId, 2, "", "");
  }

  final List<String> numberOfTrainingssessionOptions = [
    "2",
    "3",
    "4",
    "5",
    "6",
    "7"
  ];
  late String numberOfTrainingssession = numberOfTrainingssessionOptions[0];

  final List<String> trainingStatusOptions = ["Untrainiert", "Trainiert"];
  late String trainingsStatus = trainingStatusOptions[0];

  final List<String> trainingsTypeOptions = ["Mit Maschinen", "Ohne Maschinen"];
  late String trainingsType = trainingsTypeOptions[0];

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
            DropDownWidget(
              color: color,
              items: numberOfTrainingssessionOptions,
              currentValue: numberOfTrainingssession,
              itemCallBack: (String numberOfTraininssession) {
                this.numberOfTrainingssession = numberOfTraininssession;
              },
            ),
            buildQuestion(text: 'Wie trainiert bist du?'),
            DropDownWidget(
              color: color,
              items: trainingStatusOptions,
              currentValue: trainingsStatus,
              itemCallBack: (String trainingsStatus) {
                this.trainingsStatus = trainingsStatus;
              },
            ),
            buildQuestion(text: 'Wie kannst du tranieren?'),
            DropDownWidget(
              color: color,
              items: trainingsTypeOptions,
              currentValue: trainingsType,
              itemCallBack: (String trainingsType) {
                this.trainingsType = trainingsType;
              },
            ),
            RouteButtonWidget(
                color: color,
                text: 'Plan generieren',
                onClick: () {
                  setState(() {
                    preferences.numberOfTraininssession =
                        int.parse(numberOfTrainingssession);
                    preferences.trainingsStatus = trainingsStatus;
                    preferences.trainingsType = trainingsType;
                  });
                  widget.onFinished(preferences);
                })
          ],
        ),
      ),
    );
  }
}
