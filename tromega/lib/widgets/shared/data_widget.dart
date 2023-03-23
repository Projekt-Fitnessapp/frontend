//Erstellt von Tobias Fitze und Rebekka Miguez//
import 'package:flutter/material.dart';

Widget buildQuestion({required String text}) => Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 16),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );

Widget buildTextField(Color color) => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        style: TextStyle(height: 0.5),
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.unfold_more),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey))),
      ),
    );
