import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/edit_plan_view_column.dart';

class EditPlanView extends StatelessWidget {
  const EditPlanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(),
      body: Column(children: [
        Row(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10),
              child:
                  Text("Plan 1", style: Theme.of(context).textTheme.headline1)),
          Expanded(
              child: IconButton(
                  alignment: Alignment.topRight,
                  icon: const Icon(Icons.save_outlined),
                  iconSize: 32,
                  onPressed: () {})),
        ]),
        Container(
            height: 50,
            child: SizedBox(
                child: ListView(scrollDirection: Axis.horizontal, children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColorLight)),
                      onPressed: () {},
                      child: Text("Training 1"))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColorLight)),
                      onPressed: () {},
                      child: Text("Training 2"))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColorLight)),
                      onPressed: () {},
                      child: Text("Training 3"))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColorLight)),
                      onPressed: () {},
                      child: Icon(Icons.add_box))),
            ]))),
        Expanded(
            child: PageView(
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          children: const [
            EditPlanViewColumn(plan: "Training 1"),
            EditPlanViewColumn(plan: "Training 2"),
            EditPlanViewColumn(plan: "Training 3")
          ],
        ))
      ]),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
