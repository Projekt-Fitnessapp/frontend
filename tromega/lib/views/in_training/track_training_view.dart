import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:tromega/widgets/tracking/BottomDialogOptions.dart';
import 'package:tromega/widgets/tracking/ConfirmationDialog.dart';
import '../../data/trainingSession.dart';
import '../../data/tracking_http_helper.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/tracking/ExecutionPage.dart';
import '../../widgets/tracking/ExerciseThumbnail.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({Key? key}) : super(key: key);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  late TrainingSession lastSession;
  late TrainingSession thisSession;
  late TrackingHttpHelper trackingHttpHelper;
  late CustomTimerController _timerController;
  bool trainingFinished = false;
  //bool activeTimer = false;
  bool fetching = true;

  int highlightedPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  initState() {
    trackingHttpHelper = TrackingHttpHelper();
    _timerController = CustomTimerController();
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BottomDialogOptions(
                    onReset: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                            question:
                                'Sind Sie sich sicher? Dein Fortschritt geht dabei verloren.',
                            onConfirm: () =>
                                Navigator.popAndPushNamed(context, '/home'),
                          );
                        },
                      );
                    },
                    onFinish: () {
                      if (getNextToDo(0) == -1) {
                        trackingHttpHelper
                            .saveSession(thisSession)
                            .then((value) {
                          if (value) {
                            Navigator.popAndPushNamed(context, '/home');
                          }
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmationDialog(
                              question:
                                  'Sie haben noch nicht alle Übungen abgeschlossen. Trotzdem beenden?',
                              onConfirm: () {
                                trackingHttpHelper
                                    .saveSession(thisSession)
                                    .then((value) {
                                  if (value) {
                                    Navigator.popAndPushNamed(context, '/home');
                                  }
                                });
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
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
                    itemCount: thisSession.executions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExerciseThumbnail(
                        gifUrl: thisSession.executions[index].exercise.gifUrl,
                        onTapCallback: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                          setState(() {
                            highlightedPage = index;
                          });
                        },
                        isHighlighted: index == highlightedPage,
                        isDone: thisSession.executions[index].done,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics(),
                        itemCount: thisSession.executions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ExecutionPage(
                              execution: thisSession.executions[index],
                              position: index,
                              toNextExecution: () {
                                int nextPage = getNextToDo(index);
                                if (nextPage != -1) {
                                  _pageController.animateToPage(
                                    nextPage,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                  setState(() {
                                    highlightedPage = nextPage;
                                  });
                                } else {
                                  setState(() {
                                    trainingFinished = true;
                                  });
                                }
                              },
                              onFinishSet: () {
                                _timerController.reset();
                                _timerController.start();
                              },
                              onRebuild: () {
                                setState(() {
                                  if (getNextToDo(0) == -1) {
                                    trainingFinished = true;
                                  } else {
                                    trainingFinished = false;
                                  }
                                });
                              });
                        },
                      ),
                      Visibility(
                        visible: !trainingFinished,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onLongPress: () {
                                _timerController.reset();
                                _timerController.start();
                              },
                              onTap: () {
                                if (_timerController.state ==
                                    CustomTimerState.paused) {
                                  _timerController.start();
                                } else {
                                  _timerController.pause();
                                }
                              },
                              splashColor: Theme.of(context).backgroundColor,
                              child: CustomTimer(
                                controller: _timerController,
                                begin: const Duration(minutes: 3, seconds: 1),
                                end: const Duration(),
                                builder: (remaining) {
                                  return Text(
                                      '${remaining.minutes}:${remaining.seconds}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: trainingFinished,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: ElevatedButton(
                      onPressed: trainingFinished
                          ? () {
                              print('finish training');
                              trackingHttpHelper
                                  .saveSession(thisSession)
                                  .then((value) {
                                if (value) {
                                  print('Erfolgreich saved');
                                  Navigator.popAndPushNamed(context, '/home');
                                } else {
                                  print('save failed');
                                  // Meldung --> Hat nicht geklappt
                                  // Abfrahe --> Nochmal veruschen / trotzdem training beenden
                                }
                              });
                            }
                          : null,
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            'Training Abschließen',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
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
      thisSession = TrainingSession.clone(initSession);
      fetching = false;
    });
  }

  int getNextToDo(int index) {
    int nextPage =
        thisSession.executions.indexWhere((elem) => elem.done == false, index);
    if (nextPage != -1) {
      return nextPage;
    } else {
      return thisSession.executions.indexWhere((elem) => elem.done == false);
    }
  }
}
