import 'package:flutter/material.dart';
import 'package:tromega/views/account/add_my_data_view.dart';
import 'package:tromega/views/account/my_profile_view.dart';

class FirstRouteWidget extends StatefulWidget {
  const FirstRouteWidget({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _FirstRouteWidget createState() => _FirstRouteWidget();
}

class _FirstRouteWidget extends State<FirstRouteWidget> {
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
          buildTextField(),
          buildQuestion(text: 'Wie groß bist du?'),
          buildTextField(),
          buildQuestion(text: 'Wie viel wiegst du?'),
          buildTextField(),
          buildQuestion(text: 'Was ist dein Trainingsziel?'),
          const SizedBox(height: 16),
          buildDropdownButton(color,
              dropDownOptions: ["Muskeln aufbauen", "Ausdauer verbessern", "Gewicht verlieren"],
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondDataView()),
            );
          },
          child: const Text('Weiter'),
        ),
      );

  Widget buildDropdownButton(Color color,
          {required List<String> dropDownOptions,
          required String dropdownValue}) =>
      Container(
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

class SecondRouteWidget extends StatefulWidget {
  const SecondRouteWidget({super.key});

  @override
  _SecondRouteWidget createState() => _SecondRouteWidget();
}

class _SecondRouteWidget extends State<SecondRouteWidget> {
  String _dropdownValue = "Ja";
  List<String> dropDownOptions = ["Ja", "Ein bisschen", "Nein"];
  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

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
            buildQuestion(text: 'Hast du bereits Erfahrung mit Training?'),
            const SizedBox(height: 16),
            buildDropDownButton(color),
            const SizedBox(height: 16),
            buildQuestion(text: 'Wie viele Liegestützen schaffst du?'),
            buildTextField(),
            buildQuestion(text: 'Wie viele Klimmzüge schaffst du?'),
            buildTextField(),
            buildQuestion(text: 'Wie viel Kilo stemmst du?'),
            buildTextField(),
            buildQuestion(text: 'Wie häufig gehst du trainieren?'),
            buildTextField(),
            buildRegisterButton(color),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterButton(Color color) => Container(
        height: 55,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(color)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileView()),
            );
          },
          child: const Text('Registrieren'),
        ),
      );

  Widget buildDropDownButton(Color color) => Container(
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
            items:
                dropDownOptions.map<DropdownMenuItem<String>>((String mascot) {
              return DropdownMenuItem<String>(
                  value: mascot, child: Text(mascot));
            }).toList(),
            value: _dropdownValue,
            onChanged: dropdownCallback,
            iconEnabledColor: color,
            icon: const Icon(Icons.expand_more),
            isExpanded: true,
          ),
        ),
      )));
}

Widget buildQuestion({required String text}) => Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );

Widget buildTextField() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        style: TextStyle(height: 0.5),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey))),
      ),
    );
