import 'package:flutter/material.dart';

class ChangeableRowItem extends StatefulWidget {
  const ChangeableRowItem({Key? key, required this.value, required this.highlighted}) : super(key: key);
  final double value;
  final bool highlighted;

  @override
  State<ChangeableRowItem> createState() => _ChangeableRowItemState();
}

class _ChangeableRowItemState extends State<ChangeableRowItem> {
  late double currentValue;

  @override
  void initState() {
    currentValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: widget.highlighted ? Theme.of(context).highlightColor : Theme.of(context).backgroundColor,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.15,
        height: 40,
        child: Align(
          alignment: Alignment.center,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {}, 
            child: Text(
              currentValue.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        ),
      ),
    );
  }
}
