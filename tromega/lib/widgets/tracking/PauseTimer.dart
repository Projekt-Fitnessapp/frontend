import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

class PauseTimer extends StatefulWidget {
  const PauseTimer({super.key, required this.controller});
  final CustomTimerController controller;

  @override
  State<PauseTimer> createState() => _PauseTimerState();
}

class _PauseTimerState extends State<PauseTimer> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onLongPress: () {
            widget.controller.reset();
            widget.controller.start();
          },
          onTap: () {
            if (widget.controller.state == CustomTimerState.paused) {
              widget.controller.start();
            } else {
              widget.controller.pause();
            }
          },
          splashColor: Theme.of(context).backgroundColor,
          child: CustomTimer(
            controller: widget.controller,
            begin: const Duration(minutes: 3),
            end: const Duration(),
            builder: (remaining) {
              return Text('${remaining.minutes}:${remaining.seconds}', style: Theme.of(context).textTheme.headlineLarge);
            },
          ),
        ),
      ),
    );
  }
}
