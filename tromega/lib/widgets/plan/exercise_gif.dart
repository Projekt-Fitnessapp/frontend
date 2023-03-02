import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class ExerciseGif extends StatefulWidget {
  //Gif mit Border und Container für Übungskarten

  const ExerciseGif({super.key, required this.gif});
  final String gif;

  @override
  State<ExerciseGif> createState() => _ExerciseGifState();
}

class _ExerciseGifState extends State<ExerciseGif>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              placeholder: (context) => const SizedBox(
                  width: 120,
                  height: 120,
                  child: Padding(
                    padding: EdgeInsets.all(35.0),
                    child: CircularProgressIndicator(),
                  )),
              image: Image.network(
                widget.gif,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ).image,
              autostart: Autostart.no,
            )));
  }
}
