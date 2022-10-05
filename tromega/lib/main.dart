import 'package:flutter/material.dart';

// Main Views
import './views/home_view.dart';
import 'views/plans/plan_overview.dart';
import './views/statistics_view.dart';
import './views/social_space_view.dart';
import 'views/account/my_profile_view.dart';

// Secondary Views
import 'views/plans/edit_training_view.dart';
import 'views/in_training/track_training_view.dart';
import './views/test_and_dev_view.dart';
import './views/plans/add_exercise.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            backgroundColor: Colors.white,
            primaryColor: const Color(0xff003050),
            primaryColorLight: const Color(0xff5cbffb),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xff003050),
              )),
            ),
            iconTheme: const IconThemeData(
              color: const Color(0xff003050),
            ),
            textTheme: const TextTheme(
                headline1: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Proxima Nova Bold',
                    color: const Color(0xff003050),
                    letterSpacing: -0.5),
                labelMedium: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Proxima Nova',
                    color: const Color(0xff003050),
                    letterSpacing: -0.5))
            //please add the colors you need for your views in this theme
            ),
        routes: {
          '/': (context) => const DevView(),
          '/home': (context) => const HomeView(),
          '/myWorkoutPlans': (context) => PlanOverview(),
          '/myStatistics': (context) => const StatisticsView(),
          '/socialSpace': (context) => const SocialSpaceView(),
          '/myProfile': (context) => const ProfileView(),
          '/testTracking': (context) => const TrackingView(),
          '/testEditPlan': (context) => EditPlanView(),
        });
  }
}
