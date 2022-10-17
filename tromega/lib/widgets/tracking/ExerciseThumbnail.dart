import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:tromega/data/exercise.dart';

class ExerciseThumbnail extends StatefulWidget {
  const ExerciseThumbnail({Key? key, required this.gifUrl, required this.onTapCallback, required this.isHighlighted, required this.isDone}) : super(key: key);
  final String gifUrl;
  final Function onTapCallback;
  final bool isHighlighted;
  final bool isDone;

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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Gif(
                image: Image.network(
                  widget.gifUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ).image,
                controller: gifController,
                autostart: Autostart.no,
                placeholder: (context) => const Center(child: CircularProgressIndicator()),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: widget.isDone
                    ? Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).primaryColorLight,
                        size: 72,
                      )
                    : Container()),
            Container(
              width: 72,
              color: Theme.of(context).backgroundColor.withOpacity(widget.isHighlighted ? 0 : 0.6),
            ),
          ],
        ),
      ),
    );
  }
}
