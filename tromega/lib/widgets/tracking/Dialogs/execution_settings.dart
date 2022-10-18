import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:tromega/widgets/tracking/Dialogs/execution_infos.dart';

import '../../../data/execution.dart';

class ExecutionSettings extends StatefulWidget {
  const ExecutionSettings({Key? key, required this.exec}) : super(key: key);
  final Execution exec;

  @override
  State<ExecutionSettings> createState() => _ExecutionSettingsState();
}

class _ExecutionSettingsState extends State<ExecutionSettings> with TickerProviderStateMixin {
  late Execution exec;
  late final GifController gifController;
  late final PageController _pageController;

  @override
  void initState() {
    exec = widget.exec;
    gifController = GifController(vsync: this);
    _pageController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  void dispose() {
    gifController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PageButton(0, 'Info'),
              PageButton(1, 'Ausführung'),
              PageButton(2, 'Historie'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              children: [
                const Text('Info - WIP'),
                ExecutionInfos(
                  gifUrl: exec.exercise.gifUrl,
                  instructions: exec.exercise.instruction,
                ),
                const Text('Historie - WIP'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget PageButton(int index, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
