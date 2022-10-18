import 'package:flutter/material.dart';
import 'package:tromega/data/execution.dart';
import '../../data/tracking_http_helper.dart';

class HistoryDataBlock extends StatefulWidget {
  const HistoryDataBlock({Key? key, required this.exerciseId})
      : super(key: key);
  final String exerciseId;

  @override
  State<HistoryDataBlock> createState() => _HistoryDataBlockState();
}

class _HistoryDataBlockState extends State<HistoryDataBlock> {
  late Execution lastExecution;
  late DateTime date;
  late TrackingHttpHelper httpHelper;
  bool fetching = true;

  @override
  void initState() {
    httpHelper = TrackingHttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetching
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Training vom ${date.day}.${date.month}.${date.year}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Satz',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'KG',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'WDH',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '10RM',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastExecution.sets
                              .asMap()
                              .entries
                              .map((entry) => HistoryDataCell(
                                  context, entry.key.toString()))
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastExecution.sets
                              .map((elem) => HistoryDataCell(
                                  context, elem.weight.toString()))
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastExecution.sets
                              .map((elem) => HistoryDataCell(
                                  context, elem.reps.toString()))
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastExecution.sets
                              .map((elem) => HistoryDataCell(
                                  context, elem.tenRM.toString()))
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget HistoryDataCell(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  void fetchData() async {
    Execution exec = await httpHelper.getLastExecution(widget.exerciseId);

    if (mounted) {
      setState(() {
        lastExecution = exec;
        date = DateTime(0);
        fetching = false;
      });
    }
  }
}
