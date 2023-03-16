import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class ExecutionInfos extends StatefulWidget {
  const ExecutionInfos({Key? key, required this.gifUrl, required this.instructions}) : super(key: key);
  final String gifUrl;
  final String instructions;

  @override
  State<ExecutionInfos> createState() => _ExecutionInfosState();
}

class _ExecutionInfosState extends State<ExecutionInfos> with TickerProviderStateMixin {
  late GifController _gifController;

  @override
  void initState() {
    _gifController = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (_gifController.isAnimating) {
                _gifController.stop();
              } else {
                _gifController.repeat();
              }
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Gif(
                image: Image.network(
                  widget.gifUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ).image,
                controller: _gifController,
                autostart: Autostart.no,
                placeholder: (context) => const CircularProgressIndicator(),
              ),
            ),
          ),
          Text(
            widget.instructions,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
