import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/edit_plan_view_column.dart';
import '../../data/classes.dart';

class EditPlanView extends StatefulWidget {
  EditPlanView({Key? key}) : super(key: key);

  @override
  State<EditPlanView> createState() => _EditPlanViewState();
}

class _EditPlanViewState extends State<EditPlanView> {
  int _count = 0;
  void _update(int count) {
    setState(() => _count = count);
  }

  int pageIndex = 0;
  PageController _pageViewController = PageController(initialPage: 0);

  var training = Training("Trainingsplan 1", [
    Day("Push", [
      Exercise("Bankdrücken", "Brust", "Langhantel", 3, 10,
          "http://d205bpvrqc9yn1.cloudfront.net/0025.gif"),
      Exercise("Kniebeugen", "Beinstrecker", "Langhantel", 3, 10,
          "http://d205bpvrqc9yn1.cloudfront.net/0043.gif")
    ]),
    Day("Pull", [
      Exercise("Kreuzheben", "Rücken", "Langhantel", 3, 10,
          "http://d205bpvrqc9yn1.cloudfront.net/0032.gif"),
      Exercise("Latzug", "Rücken", "Maschine", 3, 10,
          "http://d205bpvrqc9yn1.cloudfront.net/2330.gif")
    ])
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar_Icon(),
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
                          training.name = value;
                        },
                        textAlign: TextAlign.left,
                        controller: TextEditingController(
                          text: training.name,
                        ),
                        style: Theme.of(context).textTheme.headlineLarge!,
                        backgroundCursorColor: Colors.black,
                        cursorColor: Colors.white,
                        focusNode: FocusNode(),
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      )))),
          Flexible(
              fit: FlexFit.tight,
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
              if (training.days.isNotEmpty)
                for (var day in training.days)
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style!,
                          onPressed: () {
                            _pageViewController.animateToPage(
                                training.days.indexOf(day),
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(day.name))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style!,
                      onPressed: () {
                        training.days
                            .add(Day("Tag ${training.days.length + 1}", []));
                        setState(() {});
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
            for (var day in training.days)
              EditPlanViewColumn(day: day, update: _update, training: training),
          ],
        ))
      ]),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
