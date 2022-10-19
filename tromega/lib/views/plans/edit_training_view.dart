import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../widgets/bottom_menu.dart';
import './plan_overview.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/plan/edit_plan_view_column.dart';
import '../../data/trainingDay.dart';
import '../../data/plan_http_helper.dart';
import '../../data/trainingPlan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPlanView extends StatefulWidget {
  EditPlanView({Key? key, required this.trainingPlan}) : super(key: key);
  TrainingPlan trainingPlan;
  late TrainingPlan trainingPlanCopy = TrainingPlan("", trainingPlan.name,
      trainingPlan.split, trainingPlan.nextDay, trainingPlan.trainingDays);

  @override
  State<EditPlanView> createState() => _EditPlanViewState();
}

class _EditPlanViewState extends State<EditPlanView> {
  int _count = 0;
  late PlanHttpHelper planHttpHelper;
  void _update(int count) {
    setState(() => _count = count);
  }

  @override
  initState() {
    planHttpHelper = PlanHttpHelper();
  }

  int pageIndex = 0;
  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar_Icon(actions: []),
      body: Column(children: [
        Row(children: <Widget>[
          Flexible(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: EditableText(
                        textWidthBasis: TextWidthBasis.longestLine,
                        onSubmitted: (value) {
                          widget.trainingPlanCopy.name = value;
                        },
                        textAlign: TextAlign.left,
                        controller: TextEditingController(
                          text: widget.trainingPlanCopy.name,
                        ),
                        style: Theme.of(context).textTheme.headlineLarge!,
                        backgroundCursorColor: Colors.black,
                        cursorColor: Colors.white,
                        focusNode: FocusNode(),
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      )))),
          Flexible(
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    //alignment: Alignment.topRight,
                    icon: const Icon(Icons.save_outlined),
                    iconSize: 32,
                    onPressed: () {
                      onSave(widget.trainingPlanCopy);
                    }),
              )),
        ]),
        Container(
            height: 50,
            child: SizedBox(
                child: ListView(scrollDirection: Axis.horizontal, children: [
              if (widget.trainingPlanCopy.trainingDays.isNotEmpty)
                for (var day in widget.trainingPlanCopy.trainingDays)
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style!,
                          onPressed: () {
                            _pageViewController.animateToPage(
                                widget.trainingPlanCopy.trainingDays
                                    .indexOf(day),
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(day.name))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style!,
                      onPressed: () {
                        newTrainingDay();
                      },
                      child: Icon(Icons.add)))
            ]))),
        Expanded(
            child: PageView(
          controller: _pageViewController,
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: [
            for (var day in widget.trainingPlanCopy.trainingDays)
              EditPlanViewColumn(
                  day: day,
                  update: _update,
                  trainingPlan: widget.trainingPlanCopy),
          ],
        ))
      ]),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }

  void onSave(TrainingPlan trainingPlan) async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    var response = await planHttpHelper.putTrainingPlan(userId, trainingPlan);
    if (response) {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanOverview(),
          ));
    } else {
      showInSnackbar(context, "Speichern fehlgeschlagen");
    }
  }

  void showInSnackbar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }

  void newTrainingDay() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    TrainingDay trainingDay = TrainingDay(
        "",
        "Tag ${widget.trainingPlanCopy.trainingDays.isNotEmpty ? widget.trainingPlanCopy.trainingDays.length + 1 : "1"}",
        []);
    var response = await planHttpHelper.postTrainingDay(trainingDay, userId);
    widget.trainingPlanCopy.trainingDays.add(TrainingDay(
        response,
        "Tag ${widget.trainingPlanCopy.trainingDays.isNotEmpty ? widget.trainingPlanCopy.trainingDays.length + 1 : "1"}",
        []));
    setState(() {});
  }
}
