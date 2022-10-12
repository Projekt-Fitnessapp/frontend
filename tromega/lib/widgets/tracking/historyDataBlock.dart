import 'package:flutter/material.dart';
import '../../data/executionSet.dart';

class HistoryDataBlock extends StatelessWidget {
  const HistoryDataBlock({super.key, required this.sets, required this.date});
  final List<ExecutionSet> sets;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text('Training vom ${date.toString()}',
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
          ),
          Row(
            children: [
              Text('')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
