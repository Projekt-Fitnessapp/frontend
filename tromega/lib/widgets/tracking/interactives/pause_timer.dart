import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:tromega/widgets/tracking/Dialogs/dialog_timer_picker.dart';
import 'package:tromega/widgets/tracking/interactives/value_picker.dart';

class PauseTimer extends StatefulWidget {
  const PauseTimer(
      {super.key,
      required this.controller,
      required this.duration,
      required this.updateTimer});
  final CustomTimerController controller;
  final int duration;
  final Function updateTimer;

  @override
  State<PauseTimer> createState() => _PauseTimerState();
}

class _PauseTimerState extends State<PauseTimer> {
  late double _iconTurns;
  bool _animationState = false;

  @override
  void initState() {
    _iconTurns = 0;

    widget.controller.state.addListener(() {
      if (widget.controller.state.value == CustomTimerState.finished) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {
      if (widget.controller.state.value == CustomTimerState.finished) {
        setState(() {});
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        onEnd: () => setState(() {
          if (widget.controller.state.value == CustomTimerState.finished) {
            _animationState = !_animationState;
          }
        }),
        width: MediaQuery.of(context).size.width * 0.43,
        margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.controller.state.value == CustomTimerState.finished
              ? _animationState
                  ? Theme.of(context).highlightColor
                  : Colors.red.shade600
              : Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => DialogTimerPicker(
                    onSubmit: (newValue) {
                      widget.updateTimer(newValue);
                      Navigator.pop(context);
                    },
                    initialValue: widget.duration));
          },
          splashColor: Theme.of(context).backgroundColor,
          child: Row(
            children: [
              AnimatedRotation(
                turns: _iconTurns,
                duration: const Duration(milliseconds: 400),
                curve: Curves.decelerate,
                child: IconButton(
                    splashRadius: 8,
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      widget.controller.reset();
                      widget.controller.pause();

                      _animateResetIcon();

                      // trigger to rerender button icons
                      setState(() {});
                    },
                    icon: const Icon(Icons.restart_alt)),
              ),
              IconButton(
                  splashRadius: 8,
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      if (widget.controller.state.value !=
                          CustomTimerState.counting) {
                        widget.controller.start();
                      } else {
                        widget.controller.pause();
                      }
                    });
                  },
                  icon:
                      widget.controller.state.value != CustomTimerState.counting
                          ? const Icon(Icons.play_arrow_outlined)
                          : const Icon(Icons.pause_outlined)),
              CustomTimer(
                controller: widget.controller,
                builder: (state, time) {
                  return Text('${time.minutes}:${time.seconds}',
                      style: Theme.of(context).textTheme.headlineLarge);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _animateResetIcon() {
    setState(() {
      _iconTurns -= 1.0;
    });
  }
}
