import 'package:flutter/material.dart';
import 'package:tromega/data/executionSet.dart';
import 'package:tromega/widgets/tracking/displays/history_data_block.dart';
import '../Dialogs/execution_settings.dart';
import '../../../data/execution.dart';
import 'execution_note_display.dart';
import 'all_sets_display.dart';

class ExecutionPage extends StatefulWidget {
  const ExecutionPage(
      {Key? key, required this.execution, required this.position, required this.onRebuild, required this.onFinishSet, required this.toNextExecution})
      : super(key: key);
  final Execution execution;
  final Function toNextExecution;
  final Function onRebuild;
  final Function onFinishSet;
  final int position;
  @override
  State<ExecutionPage> createState() => _ExecutionPageState();
}

class _ExecutionPageState extends State<ExecutionPage> {
  late Execution exec;
  late String newNote;

  @override
  void initState() {
    exec = widget.execution;
    newNote = 'Notiz hinzufügen';
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
                  exec.exercise.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ExecutionSettings(
                          exec: exec,
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '${exec.exercise.equipment} \u2022 ${exec.sets.length} ${exec.sets.length == 1 ? 'Satz' : 'Sätze'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Column(
            children: exec.notes
                .asMap()
                .entries
                .map((entry) => ExecutionNoteDisplay(
                      note: entry.value,
                      position: entry.key,
                      deleteNote: (int index) {
                        setState(() {
                          exec.notes.removeAt(index);
                        });
                      },
                      changeNote: (int index, String value) {
                        setState(() {
                          exec.notes.removeAt(index);
                          exec.notes.insert(index, value);
                        });
                      },
                    ))
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: EditableText(
              textWidthBasis: TextWidthBasis.longestLine,
              onSubmitted: (value) {
                setState(() {
                  exec.notes.add(value);
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
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: AllSetsDisplay(
              executionSets: exec.sets,
              onAddSet: () {
                setState(() {
                  ExecutionSet tempSet = ExecutionSet(ExecutionType.WORKING, 10, 0, 0, false);
                  if (exec.sets.isNotEmpty) {
                    tempSet = ExecutionSet.clone(exec.sets.last);
                    tempSet.done = false;
                  }
                  exec.sets.add(tempSet);
                  exec.done = false;
                });
                widget.onRebuild();
              },
              onRemoveSet: () {
                setState(() {
                  exec.sets.removeLast();
                  if (!exec.sets.any((element) => element.done == false)) {
                    exec.done = true;
                    widget.toNextExecution();
                  }
                });
              },
              changeExecutionStatus: (isDone) {
                setState(() {
                  exec.done = isDone;
                });
                widget.onRebuild();
              },
              onFinishExecution: () {
                setState(() {
                  exec.done = true;
                });
                widget.toNextExecution();
              },
              onFinishSet: () => widget.onFinishSet(),
            ),
          ),
          HistoryDataBlock(
            exerciseId: exec.exercise.id,
          ),
        ],
      ),
    );
  }
}
