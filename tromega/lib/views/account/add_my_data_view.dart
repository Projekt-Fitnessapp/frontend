import 'package:flutter/material.dart';
import '../account/questions_widget.dart';
import '../account/second_route_widget.dart';

class FirstDataView extends StatelessWidget {
  const FirstDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildLogo(),
          const SizedBox(height: 24),
          const FirstRouteWidget(),
        ],
      ),
    );
  }
}

class SecondDataView extends StatelessWidget {
  const SecondDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildLogo(),
          const SizedBox(height: 24),
          const SecondRouteWidget(),
        ],
      ),
    );
  }
}

Widget buildLogo() => Container(
    width: 100,
    height: 100,
    alignment: Alignment.center,
    child: Image.asset('public/TrOmega_dark.png', fit: BoxFit.cover));
