import 'package:flutter/material.dart';

class ExerciseContainer extends StatelessWidget {
  const ExerciseContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Row(children: <Widget>[
              Image.network(
                "http://d205bpvrqc9yn1.cloudfront.net/0585.gif",
                fit: BoxFit.cover,
                height: 110,
                alignment: Alignment.center,
              ),
              Expanded(
                  child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text("Beinstrecken",
                          style: Theme.of(context).textTheme.headline1)),
                  Expanded(
                      child: IconButton(
                          alignment: Alignment.topRight,
                          icon: const Icon(Icons.close),
                          iconSize: 15,
                          onPressed: () {}))
                ]),
                Expanded(
                    child: Row(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        child: const Text('3 Sätze'),
                        onPressed: () {/* ... */},
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        child: const Text('10 Wdh'),
                        onPressed: () {/* ... */},
                      ))
                ])),
              ])),
            ])));
  }
}
