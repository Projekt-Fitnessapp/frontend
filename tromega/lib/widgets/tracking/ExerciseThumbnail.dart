import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:tromega/data/exercise.dart';

class ExerciseThumbnail extends StatefulWidget {
  const ExerciseThumbnail({Key? key, required this.exercise, required this.onTapCallback}) : super(key: key);
  final Exercise exercise;
  final Function onTapCallback;

  @override
  State<ExerciseThumbnail> createState() => _ExerciseThumbnailState();
}

class _ExerciseThumbnailState extends State<ExerciseThumbnail> with TickerProviderStateMixin {
  late final GifController gifController;

  @override
  void initState() {
    gifController = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        onTap: () => widget.onTapCallback(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Gif(
            image: Image.network(
              widget.exercise.gifUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ).image,
            controller: gifController,
            autostart: Autostart.no,
            placeholder: (context) => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
