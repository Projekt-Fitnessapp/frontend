import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class ExerciseGif extends StatefulWidget {
  final String gif;
  ExerciseGif({super.key, required this.gif});

  @override
  State<ExerciseGif> createState() => _ExerciseGifState();
}

class _ExerciseGifState extends State<ExerciseGif>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Gif(
      image: Image.network(
        widget.gif,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        height: 110,
      ).image,
      autostart: Autostart.no,
    );
  }
}
