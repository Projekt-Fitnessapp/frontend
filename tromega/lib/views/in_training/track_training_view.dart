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
  bool trainingFinished = false;
  bool fetching = true;

  int highlightedPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  initState() {
    trackingHttpHelper = TrackingHttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(
        actions: [
          IconButton(
            splashRadius: 10,
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
                            question: 'Sind Sie sich sicher? Dein Fortschritt geht dabei verloren.',
                            onConfirm: () => Navigator.popAndPushNamed(context, '/home'),
                          );
                        },
                      );
                    },
                    onFinish: () {
                      if (getNextToDo(0) == -1) {
                        trackingHttpHelper.saveSession(thisSession).then((value) {
                          if (value) {
                            Navigator.popAndPushNamed(context, '/home');
                          }
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmationDialog(
                              question: 'Sie haben noch nicht alle Übungen abgeschlossen. Trotzdem beenden?',
                              onConfirm: () {
                                trackingHttpHelper.saveSession(thisSession).then((value) {
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
                          _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
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
                  child: PageView.builder(
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
                              print('Training abgeschlossen');
                              setState(() {
                                trainingFinished = true;
                              });
                            }
                          },
                          onRebuild: () {
                            setState(() {});
                          });
                    },
                  ),
                ),
                Visibility(
                  visible: trainingFinished,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: ElevatedButton(
                      onPressed: trainingFinished
                          ? () {
                              trackingHttpHelper.saveSession(thisSession).then((value) {
                                if (value) {
                                  Navigator.popAndPushNamed(context, '/home');
                                } else {
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
    int nextPage = thisSession.executions.indexWhere((elem) => elem.done == false, index);
    if (nextPage != -1) {
      return nextPage;
    } else {
      return thisSession.executions.indexWhere((elem) => elem.done == false);
    }
  }
}
