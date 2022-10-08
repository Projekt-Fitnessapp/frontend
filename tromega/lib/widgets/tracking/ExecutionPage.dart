import 'package:flutter/material.dart';
import '../../data/execution.dart';
import './ExecutionNoteDisplay.dart';

class ExecutionPage extends StatefulWidget {
  const ExecutionPage({Key? key, required this.execution, required this.position}) : super(key: key);
  final Execution execution;
  final int position;
  @override
  State<ExecutionPage> createState() => _ExecutionPageState();
}

class _ExecutionPageState extends State<ExecutionPage> {
  late String newNote;

  @override
  void initState() {
    newNote = 'Notiz Hinzufügen';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.execution.exercise.name,
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: widget.execution.notes.map((note) => ExecutionNoteDisplay(note: note)).toList(),
          ),
          EditableText(
            textWidthBasis: TextWidthBasis.longestLine,
            onSubmitted: (value) {
              setState(() {
                widget.execution.notes.add(value);
              });
            },
            textAlign: TextAlign.left,
            controller: TextEditingController(
              text: newNote,
            ),
            style: const TextStyle(color: Colors.grey),
            backgroundCursorColor: Colors.black,
            cursorColor: Colors.white,
            focusNode: FocusNode(),
          )
        ],
      ),
    );
  }
}
