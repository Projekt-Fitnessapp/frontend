import 'package:flutter/material.dart';

class BottomDialogOptions extends StatelessWidget {
  const BottomDialogOptions({Key? key, required this.onReset, required this.onFinish}) : super(key: key);
  final Function onReset;
  final Function onFinish;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            OptionsButton(
              icon: const Icon(Icons.check_rounded),
              text: 'Training abschließen',
              onPressed: onFinish,
            ),
            OptionsButton(
              icon: const Icon(Icons.replay_sharp),
              text: 'Training zurücksetzen',
              onPressed: onReset,
            ),
          ],
        ),
      ),
    );
  }

  Widget OptionsButton({icon: Icon, text: String, onPressed: Function}) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: icon,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
