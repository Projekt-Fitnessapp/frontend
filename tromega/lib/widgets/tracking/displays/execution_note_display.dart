// Author: Matthias
import 'package:flutter/material.dart';

class ExecutionNoteDisplay extends StatefulWidget {
  const ExecutionNoteDisplay({Key? key, required this.changeNote, required this.deleteNote, required this.position, required this.note}) : super(key: key);
  final Function changeNote;
  final Function deleteNote;
  final int position;
  final String note;

  @override
  State<ExecutionNoteDisplay> createState() => _ExecutionNoteDisplayState();
}

class _ExecutionNoteDisplayState extends State<ExecutionNoteDisplay> {
  late String noteValue;
  late TextEditingController textController;
  late FocusNode textFocusNode;

  @override
  void initState() {
    noteValue = widget.note;
    textController = TextEditingController(
      text: noteValue,
    );
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: EditableText(
          textWidthBasis: TextWidthBasis.longestLine,
          onSubmitted: (value) {
            if (value.isEmpty) {
              widget.deleteNote(widget.position);
            } else {
              widget.changeNote(widget.position, value);
            }
          },
          textAlign: TextAlign.left,
          controller: textController,
          style: Theme.of(context).textTheme.bodyLarge!,
          backgroundCursorColor: Colors.black,
          cursorColor: Colors.white,
          focusNode: textFocusNode,
        ),
      ),
    );
  }
}
