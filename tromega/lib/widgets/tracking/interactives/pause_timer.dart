import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/Dialogs/dialog_timer_picker.dart';
import 'package:tromega/widgets/tracking/interactives/value_picker.dart';

class PauseTimer extends StatefulWidget {
  const PauseTimer({super.key, required this.controller});
  final CustomTimerController controller;

  @override
  State<PauseTimer> createState() => _PauseTimerState();
}

class _PauseTimerState extends State<PauseTimer> {
  late int timerSeconds;

  @override
  void initState() {
    timerSeconds = 180;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) => const DialogTimerPicker()
            );
          },
          splashColor: Theme.of(context).backgroundColor,
          child: Row(
            children: [
              IconButton(
                  splashRadius: 8,
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    widget.controller.reset();
                    widget.controller.pause();
                  },
                  icon: const Icon(Icons.restart_alt)),
              IconButton(
                  splashRadius: 8,
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      if (widget.controller.state !=
                          CustomTimerState.counting) {
                        widget.controller.start();
                      } else {
                        widget.controller.pause();
                      }
                    });
                  },
                  icon: widget.controller.state != CustomTimerState.counting
                      ? const Icon(Icons.play_arrow_outlined)
                      : const Icon(Icons.pause_outlined)),
              CustomTimer(
                controller: widget.controller,
                begin: Duration(seconds: timerSeconds),
                end: const Duration(),
                builder: (remaining) {
                  return Text('${remaining.minutes}:${remaining.seconds}',
                      style: Theme.of(context).textTheme.headlineLarge);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
