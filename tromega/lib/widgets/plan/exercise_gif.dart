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
    return Container(
        height: 80,
        margin: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.65),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Gif(
              image: Image.network(
                widget.gif,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ).image,
              autostart: Autostart.no,
            )));
  }
}
