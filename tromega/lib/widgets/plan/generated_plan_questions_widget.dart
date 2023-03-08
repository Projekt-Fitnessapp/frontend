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
  final List<String> trainingStatusOptionsEnglish = ["untrained", "trained"];
  late String trainingsStatus = trainingStatusOptions[0];

  final List<String> trainingsTypeOptions = ["Mit Maschinen", "Ohne Maschinen"];
  final List<String> trainingsTypeOptionsEnglish = [
    "withMachines",
    "withoutMachines"
  ];
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
              itemCallBack: (String numberOfTrainingssession) {
                setState(() {
                  this.numberOfTrainingssession = numberOfTrainingssession;
                });
              },
            ),
            buildQuestion(text: 'Wie trainiert bist du?'),
            DropDownWidget(
              color: color,
              items: trainingStatusOptions,
              currentValue: trainingsStatus,
              itemCallBack: (String trainingsStatus) {
                setState(() {
                  this.trainingsStatus = trainingsStatus;
                  if (trainingsStatus == trainingStatusOptions[0]) {
                    trainingsType = trainingsTypeOptions[0];
                  }
                });
              },
            ),
            trainingsStatus == trainingStatusOptions[1]
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        buildQuestion(text: 'Wie kannst du tranieren?'),
                        DropDownWidget(
                          color: color,
                          items: trainingsTypeOptions,
                          currentValue: trainingsType,
                          itemCallBack: (String trainingsType) {
                            setState(() {
                              this.trainingsType = trainingsType;
                            });
                          },
                        ),
                      ])
                : Container(),
            RouteButtonWidget(
                color: color,
                text: 'Plan generieren',
                onClick: () {
                  setState(() {
                    preferences.numberOfTrainingssession =
                        int.parse(numberOfTrainingssession);
                    if (trainingsStatus == trainingStatusOptions[0]) {
                      preferences.trainingsStatus =
                          trainingStatusOptionsEnglish[0];
                    } else if (trainingsStatus == trainingStatusOptions[1]) {
                      preferences.trainingsStatus =
                          trainingStatusOptionsEnglish[1];
                    }
                    if (trainingsType == trainingsTypeOptions[0]) {
                      preferences.trainingsType =
                          trainingsTypeOptionsEnglish[0];
                    } else if (trainingsStatus == trainingStatusOptions[1]) {
                      preferences.trainingsType =
                          trainingsTypeOptionsEnglish[1];
                    }
                  });
                  widget.onFinished(preferences);
                })
          ],
        ),
      ),
    );
  }
}
