// Matthias

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif/gif.dart';
import '../../data/exercise.dart';
import '../../data/execution.dart';
import '../../data/trainingSession.dart';
import '../../data/tracking_http_helper.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({Key? key}) : super(key: key);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> with TickerProviderStateMixin {
  // later from api request
  late TrainingSession lastSession;
  late TrackingHttpHelper trackingHttpHelper;
  bool fetching = true;

  final PageController _pageController = PageController();

  @override
  initState() {
    trackingHttpHelper = TrackingHttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hier Icon einfügen')),
        backgroundColor: Colors.blue[100],
        body: fetching
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      itemCount: lastSession.executions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExerciseThumbnail(lastSession.executions[index].exercise);
                      },
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      physics: const PageScrollPhysics(),
                      itemCount: lastSession.executions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExecutionPage(lastSession.executions[index]);
                      },
                    ),
                  )
                ],
              ));
  }

  Widget ExerciseThumbnail(Exercise exercise) {
    GifController gifController = GifController(vsync: this);

    print(exercise.gifUrl);
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Gif(
          image: Image.network(
            exercise.gifUrl,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ).image,
          controller: gifController,
          autostart: Autostart.no,
          placeholder: (context) => const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget ExecutionPage(Execution exec) {
    return Text(exec.exercise.name);
  }

  void fetchData() async {
    TrainingSession initSession = await trackingHttpHelper.getMockSession();
    setState(() {
      lastSession = initSession;
      fetching = false;
    });
  }
}
