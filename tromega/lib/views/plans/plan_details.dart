import '../../widgets/plan/edit_plan_view_column.dart';
import '../../widgets/plan/plan_view_column.dart';
import './edit_training_view.dart';
import '../../widgets/plan/trainingstagBtn.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/trainingPlan.dart';

class PlanDetailsView extends StatefulWidget {
  //View für die Visualisierung eines Trainingsplans mit seinen Trainingstagen
  const PlanDetailsView({Key? key, required this.trainingPlan})
      : super(key: key);
  final TrainingPlan trainingPlan;

  @override
  State<PlanDetailsView> createState() => _PlanDetailsViewState();
}

class _PlanDetailsViewState extends State<PlanDetailsView> {
  late PageController _pageViewController;
  int pageIndex = 0;

  @override
  initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Flexible(
                flex: 9,
                child: Text(widget.trainingPlan.name,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 32,
                        onPressed: () async {
                          //Navigation in die View zum editieren des Plans
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPlanView(
                                  trainingPlan: widget.trainingPlan,
                                ),
                              ));
                        }),
                  ))
            ],
          ),
        ),
        SizedBox(
            height: 50,
            child: SizedBox(
                child: ListView(scrollDirection: Axis.horizontal, children: [
              if (widget.trainingPlan.trainingDays.isNotEmpty)
                for (var day in widget.trainingPlan.trainingDays)
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style!,
                          onPressed: () {
                            _pageViewController.animateToPage(
                                widget.trainingPlan.trainingDays.indexOf(day),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(day.name))),
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
            for (var day in widget.trainingPlan.trainingDays)
              PlanViewColumn(day: day, trainingPlan: widget.trainingPlan),
          ],
        ))
      ]),
    );
  }
}
