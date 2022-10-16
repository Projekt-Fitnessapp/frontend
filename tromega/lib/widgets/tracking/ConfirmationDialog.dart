import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({Key? key, required this.question, required this.onConfirm}) : super(key: key);
  final String question;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        question,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Abbrechen',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
          },
          child: Text(
            'Bestätigen',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
