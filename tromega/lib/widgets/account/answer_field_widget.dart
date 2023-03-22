import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Erstellt von Rebekka Miguez//


class AnswerFieldWidget extends StatefulWidget {
  //Texfelder zum Antworten auf die Registrierungsfragen

  final int maxLength;
  final String regExp;
  final String hintText;
  final String suffixText;
  late TextEditingController controller;

  AnswerFieldWidget(
      {Key? key,
      required this.maxLength,
      required this.hintText,
      required this.suffixText,
      required this.controller,
      required this.regExp})
      : super(key: key);

  @override
  State<AnswerFieldWidget> createState() => _AnswerFieldWidgetState();
}

class _AnswerFieldWidgetState extends State<AnswerFieldWidget> {
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(widget.regExp)),
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        controller: widget.controller,
        style: const TextStyle(height: 0.5),
        decoration: InputDecoration(
            hintText: widget.hintText,
            suffixText: widget.suffixText,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey))),
      ),
    );
  }
}
