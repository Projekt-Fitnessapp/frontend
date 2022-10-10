import 'package:flutter/material.dart';
import 'package:tromega/views/account/add_my_data_view.dart';
import 'package:tromega/widgets/account/data_widget.dart';

class FirstQuestionWidget extends StatefulWidget {
  const FirstQuestionWidget({Key? key, this.title, required this.onClick})
      : super(key: key);

  final Function onClick;
  final String? title;

  @override
  _FirstQuestionWidget createState() => _FirstQuestionWidget();
}

class _FirstQuestionWidget extends State<FirstQuestionWidget> {
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
          buildQuestion(text: 'Wie alt bist du?'),
          buildTextField(color),
          buildQuestion(text: 'Wie groß bist du?'),
          buildTextField(color),
          buildQuestion(text: 'Wie viel wiegst du?'),
          buildTextField(color),
          buildQuestion(text: 'Was ist dein Trainingsziel?'),
          const SizedBox(height: 16),
          buildDropdownButton(color,
              dropDownOptions: [
                "Muskeln aufbauen",
                "Ausdauer verbessern",
                "Gewicht verlieren"
              ],
              dropdownValue: "Muskeln aufbauen"),
          const SizedBox(height: 16),
          buildQuestion(text: 'Mit welchem Geschlecht identifizierst du dich?'),
          const SizedBox(height: 16),
          buildDropdownButton(color,
              dropDownOptions: ["männlich", "weiblich", "divers"],
              dropdownValue: "männlich"),
          const SizedBox(height: 32),
          buildRouteButton(color),
        ],
      )),
    );
  }

  Widget buildRouteButton(Color color) => Container(
        height: 55,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(color)),
          onPressed: () {
            widget.onClick();
          },
          child: const Text('Weiter'),
        ),
      );

  Widget buildDropdownButton(Color color,
      {required List<String> dropDownOptions, required String dropdownValue}) {
    return Container(
        height: 55,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        child: (InputDecorator(
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: dropDownOptions
                  .map<DropdownMenuItem<String>>((String mascot) {
                return DropdownMenuItem<String>(
                    value: mascot, child: Text(mascot));
              }).toList(),
              value: dropdownValue,
              onChanged: (String? changedValue) {
                setState(() {
                  dropdownValue = changedValue!;
                });
              },
              iconEnabledColor: color,
              icon: const Icon(Icons.expand_more),
              isExpanded: true,
            ),
          ),
        )));
  }
}
