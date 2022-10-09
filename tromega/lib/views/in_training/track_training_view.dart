import 'package:flutter/material.dart';
import '../../data/trainingSession.dart';
import '../../data/tracking_http_helper.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/tracking/ExecutionPage.dart';
import '../../widgets/tracking/ExerciseThumbnail.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({Key? key}) : super(key: key);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
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
      appBar: AppBar_Icon(),
      backgroundColor: Theme.of(context).backgroundColor,
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
                      return ExerciseThumbnail(
                        exercise: lastSession.executions[index].exercise,
                        onTapCallback: () {
                          _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                        },
                      );
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
                      return ExecutionPage(execution: lastSession.executions[index], position: index);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void fetchData() async {
    TrainingSession initSession = await trackingHttpHelper.getMockSession();
    setState(() {
      lastSession = initSession;
      fetching = false;
    });
  }
}
