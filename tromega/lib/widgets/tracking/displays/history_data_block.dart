import 'package:flutter/material.dart';
import 'package:tromega/data/execution.dart';
import '../../../data/tracking_http_helper.dart';

class HistoryDataBlock extends StatefulWidget {
  const HistoryDataBlock({Key? key, required this.exerciseId, required this.trainingDayId}) : super(key: key);
  final String exerciseId, trainingDayId;

  @override
  State<HistoryDataBlock> createState() => _HistoryDataBlockState();
}

class _HistoryDataBlockState extends State<HistoryDataBlock> {
  late Execution? lastExecution;
  late TrackingHttpHelper httpHelper;
  bool fetching = true;

  @override
  void initState() {
    httpHelper = const TrackingHttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetching || lastExecution == null
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
                          'Training vom ${lastExecution!.date.day}.${lastExecution!.date.month}.${lastExecution!.date.year}',
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
                          children: lastExecution!.sets.asMap().entries.map((entry) => buildHistoryDataCell(context, entry.key.toString())).toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastExecution!.sets.map((elem) => buildHistoryDataCell(context, elem.weight.toString())).toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastExecution!.sets.map((elem) => buildHistoryDataCell(context, elem.reps.toString())).toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastExecution!.sets.map((elem) => buildHistoryDataCell(context, elem.tenRM.toString())).toList(),
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

  Widget buildHistoryDataCell(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  void fetchData() async {
    Execution? exec = await httpHelper.getLastExecution(widget.trainingDayId, widget.exerciseId);

    if (mounted && exec!=null) {
      setState(() {
        lastExecution = exec;
        fetching = false;
      });
    }
  }
}
