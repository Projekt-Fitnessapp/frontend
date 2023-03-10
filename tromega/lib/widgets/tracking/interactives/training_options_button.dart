import 'package:flutter/material.dart';
import 'package:tromega/data/tracking_http_helper.dart';
import 'package:tromega/data/training_session.dart';
import 'package:tromega/widgets/tracking/Dialogs/bottom_dialog_options.dart';
import 'package:tromega/widgets/tracking/Dialogs/confirmation_dialog.dart';

class TrainingOptionsButton extends StatelessWidget {
  const TrainingOptionsButton({super.key, required this.thisSession});
  final TrainingSession thisSession;
  final TrackingHttpHelper _trackingHttpHelper = const TrackingHttpHelper();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomDialogOptions(
              onReset: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationDialog(
                      question:
                          'Sind Sie sich sicher? Dein Fortschritt geht dabei verloren.',
                      onConfirm: () =>
                          Navigator.popAndPushNamed(context, '/app'),
                    );
                  },
                );
              },
              onFinish: () {
                if (getNextToDo(0) == -1) {
                  _trackingHttpHelper.saveSession(thisSession).then((value) {
                    if (value) {
                      Navigator.popAndPushNamed(context, '/app');
                    }
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        question:
                            'Sie haben noch nicht alle Übungen abgeschlossen. Trotzdem beenden?',
                        onConfirm: () {
                          _trackingHttpHelper
                              .saveSession(thisSession)
                              .then((value) {
                            if (value) {
                              Navigator.popAndPushNamed(context, '/app');
                            }
                          });
                        },
                      );
                    },
                  );
                }
              },
            );
          },
        );
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  int getNextToDo(int index) {
    int nextPage =
        thisSession.executions.indexWhere((elem) => elem.done == false, index);
    if (nextPage != -1) {
      return nextPage;
    } else {
      return thisSession.executions.indexWhere((elem) => elem.done == false);
    }
  }
}
