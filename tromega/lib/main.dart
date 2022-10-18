import 'package:flutter/material.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/widgets/shared/theme.dart';

// Main Views
import './views/home_view.dart';
import 'views/plans/plan_overview.dart';
import './views/statistics_view.dart';
import './views/social_space_view.dart';
import 'views/account/my_profile_view.dart';

// Secondary Views
import 'views/plans/edit_training_view.dart';
import 'views/in_training/track_training_view.dart';
import 'views/account/add_my_data_view.dart';
import 'views/account/sso_view.dart';
import 'views/account/edit_profile_view.dart';
import './views/test_and_dev_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: tromegaTheme(),
      routes: {
        '/': (context) => const DevView(),
        '/home': (context) => const HomeView(),
        '/myWorkoutPlans': (context) => PlanOverview(),
        '/myStatistics': (context) => const StatisticsView(),
        '/socialSpace': (context) => const SocialSpaceView(),
        '/myProfile': (context) =>   const ProfileView(),
        '/testTracking': (context) => const TrackingView(),
        '/testEditPlan': (context) => EditPlanView(),
        '/myLogin': (context) => const LoginView(),
        '/editProfile': (context) => const EditProfile()
      },
    );
  }
}
