import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainingsplanBtn extends StatelessWidget {
  final String name;

  const TrainingsplanBtn({super.key, required this.name});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8.0),
          FloatingActionButton.extended(
            extendedPadding: const EdgeInsetsDirectional.all(50.0),
            label: Text(name,
                style: const TextStyle(fontSize: 33, color: Colors.black)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.white,
            onPressed: () {},
          ),
          const SizedBox(height: 8.0),
        ],
      );
}
