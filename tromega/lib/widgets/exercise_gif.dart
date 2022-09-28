import 'package:flutter/cupertino.dart';
import 'package:gif/gif.dart';

class ExerciseGif extends StatelessWidget {
  final String gif;
  ExerciseGif({super.key, required this.gif});

  Widget build(BuildContext context) {
    return Gif(
      image: Image.network(
        gif,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        height: 110,
      ).image,
      autostart: Autostart.no,
    );
  }
}
