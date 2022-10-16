import './edit_training_view.dart';
import '../../widgets/plan/trainingstagBtn.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/trainingPlan.dart';

class PlanDetailsView extends StatefulWidget {
  const PlanDetailsView({Key? key, required this.trainingPlan})
      : super(key: key);
  final TrainingPlan trainingPlan;

  @override
  State<PlanDetailsView> createState() => _PlanDetailsViewState();
}

class _PlanDetailsViewState extends State<PlanDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.trainingPlan.name,
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          //alignment: Alignment.topRight,
                          icon: const Icon(Icons.edit_outlined),
                          iconSize: 32,
                          onPressed: () async {
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.trainingPlan.trainingDays.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TrainingstagBtn(
                            index: index,
                            trainingDay:
                                widget.trainingPlan.trainingDays[index],
                            trainingPlan: widget.trainingPlan,
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
