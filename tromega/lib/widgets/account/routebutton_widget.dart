import 'package:flutter/material.dart';

class RouteButtonWidget extends StatefulWidget {
  const RouteButtonWidget({
    super.key,
    required this.color,
    required this.text,
    required this.onClick,
  });
  final Color color;
  final String text;
  final Function onClick;

  @override
  State<RouteButtonWidget> createState() => _RouteButtonWidgetState();
}

class _RouteButtonWidgetState extends State<RouteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: widget.color),
        onPressed: () {
          widget.onClick();
        },
        child: Text(widget.text),
      ),
    );
  }
}
