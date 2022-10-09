import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  const RowItem({Key? key, required this.value, required this.highlighted}) : super(key: key);
  final String value;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: highlighted ? Theme.of(context).highlightColor : Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
