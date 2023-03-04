import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnswerFieldWidget extends StatefulWidget {
  final int maxLines;
  final String regExp;
  late TextEditingController controller;

  AnswerFieldWidget(
      {Key? key,
      this.maxLines = 1,
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
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(widget.regExp))],
        controller: widget.controller,
        style: const TextStyle(height: 0.5),
        decoration: const InputDecoration(
            suffixIcon: Icon(Icons.unfold_more),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey))),
      ),
    );
  }
}
