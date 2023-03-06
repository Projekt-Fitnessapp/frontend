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
  late num currentValue;
  late List<num> valueList;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    currentValue = widget.standardValue ?? widget.minValue;
    valueList = [10, 20, 30];  //widget.values ?? getListValues();

    print(valueList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView.builder(
        itemCount: valueList.length,
        controller: controller,
        itemBuilder: (context, index) {
          return Container(
            height: 16,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            child: Text(valueList[index].toString(),
                style: Theme.of(context).textTheme.headlineSmall),
          );
        },
      ),
      // Stack(
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         ShaderMask(
      //           shaderCallback: (bounds) {
      //             return const LinearGradient(
      //                     colors: [Colors.white, Colors.transparent])
      //                 .createShader(bounds);
      //           },
      //           child: const SizedBox(
      //             height: 28,
      //           ),
      //         ),
      //         Container(
      //           height: 28,
      //           decoration: const BoxDecoration(color: Colors.transparent),
      //         ),
      //         ShaderMask(
      //           shaderCallback: (bounds) {
      //             return const LinearGradient(
      //                     colors: [Colors.transparent, Colors.white])
      //                 .createShader(bounds);
      //           },
      //           child: const SizedBox(
      //             height: 28,
      //           ),
      //         ),
      //       ],
      //     ),
      //     ListView.builder(
      //       itemCount: valueList.length,
      //       controller: controller,
      //       itemBuilder: (context, index) {
      //         return Container(
      //           height: 16,
      //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      //           child: Text(valueList[index].toString(),
      //               style: Theme.of(context).textTheme.headlineSmall),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }

  List<num> getListValues() {
    List<num> items = [];

    for (num i = widget.minValue;
        i < widget.maxValue;
        i = i + widget.stepSize) {
      items.add(i);
    }
    items.add(widget.maxValue);
    return items;
  }
}
