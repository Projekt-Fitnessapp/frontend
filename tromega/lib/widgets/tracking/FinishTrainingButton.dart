import 'package:flutter/material.dart';
import 'package:tromega/data/tracking_http_helper.dart';
import '../../data/trainingSession.dart';

class FinishTrainingButton extends StatelessWidget {
  const FinishTrainingButton({super.key, required this.trainingFinished, required this.thisSession});
  final bool trainingFinished;
  final TrainingSession thisSession;
  final TrackingHttpHelper _trackingHttpHelper = const TrackingHttpHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
      child: ElevatedButton(
        onPressed: trainingFinished
            ? () {
                print('finish training');
                _trackingHttpHelper.saveSession(thisSession).then((value) {
                  if (value) {
                    print('Erfolgreich saved');
                    Navigator.popAndPushNamed(context, '/home');
                  } else {
                    print('save failed');
                    // Meldung --> Hat nicht geklappt
                    // Abfrahe --> Nochmal veruschen / trotzdem training beenden
                  }
                });
              }
            : null,
        child: SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'Training Abschließen',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}
