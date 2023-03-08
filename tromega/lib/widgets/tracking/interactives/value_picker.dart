import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

enum ValueType {
  integer,
  decimal,
}

class ValuePicker extends StatefulWidget {
  const ValuePicker(
      {super.key,
      this.type = ValueType.integer,
      this.values,
      this.standardValue,
      this.maxValue = 50,
      this.minValue = 100,
      this.stepSize = 1,
      this.onChange,
      this.onSubmit});

  final ValueType type;
  final List<num>? values;
  final num maxValue;
  final num minValue;
  final num stepSize;
  final num? standardValue;
  final Function? onChange;
  final Function? onSubmit;

  @override
  State<ValuePicker> createState() => ValuePickerState();
}

class ValuePickerState extends State<ValuePicker> {
  final int _itemSize = 30;
  late bool _scrolling;
  late int currentIndex;
  late dynamic currentValue;
  late List<dynamic> valueList;
  late ScrollController controller;

  @override
  void initState() {
    _scrolling = false;

    // adding white spaces, for animation purposes
    valueList = [""];
    valueList.addAll(widget.values ?? getListValues());
    valueList.add("");

    currentValue = widget.standardValue ?? widget.minValue;
    currentIndex = valueList.indexOf((element) => element == currentValue);

    // set current position
    controller = ScrollController(
        keepScrollOffset: true,
        initialScrollOffset: (currentIndex - 1 * _itemSize).toDouble());

    //controller.position.isScrollingNotifier.addListener(() {
    //  if (controller.position.isScrollingNotifier.value) {
    //    print("scroll started");
    //  } else {
    //    print("scroll stopped");
    //  }
    //});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90, // space for 3 values
      width: MediaQuery.of(context).size.width * 0.6,
      child: NotificationListener(
        onNotification: (notification) {
          if (mounted) {
            if (notification is ScrollUpdateNotification) {
              // only change if necessary
              // +1 to ignore white space
              // 0.5*_itemSize to highlight middle item
              if (((controller.offset + 0.5 * _itemSize) ~/ _itemSize) + 1 !=
                  currentIndex) {
                setState(() {
                  currentIndex =
                      ((controller.offset + 0.5 * _itemSize) ~/ _itemSize) + 1;
                });
              }
            } else if (notification is ScrollStartNotification) {
              _scrolling = true;
            } else if (_scrolling && notification is ScrollEndNotification) {
              // catching multiple end notifications fired by animateTo()
              _scrolling = false;
              currentValue = valueList[currentIndex];
              controller.animateTo(((currentIndex - 1) * _itemSize).toDouble(),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            }
          }
          return true;
        },
        child: ListView.builder(
          itemCount: valueList.length,
          controller: controller,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  currentIndex = index;
                  currentValue = valueList[currentIndex];
                });
                controller.animateTo(((index - 1) * _itemSize).toDouble(),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              onDoubleTap: () {
                // Submit Value
              },
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(valueList[index].toString(),
                      style: index == currentIndex
                          ? Theme.of(context).textTheme.displayLarge
                          : Theme.of(context).textTheme.titleLarge),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<num> getListValues() {
    List<num> items = [];

    for (num i = widget.minValue;
        i <= widget.maxValue;
        i = i + widget.stepSize) {
      items.add(i);
    }
    return items;
  }
}
