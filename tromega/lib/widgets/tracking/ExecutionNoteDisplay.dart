import 'package:flutter/cupertino.dart';

class ExecutionNoteDisplay extends StatelessWidget {
  const ExecutionNoteDisplay({Key? key, required this.note}) : super(key: key);
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(note),
      ),
    );
  }
}
