import 'package:flutter/material.dart';
import 'package:tromega/app.dart';
import 'package:tromega/data/trainingPlan.dart';
import 'package:tromega/widgets/shared/theme.dart';

// Main Views
import './views/home_view.dart';
import 'views/plans/plan_overview.dart';
import './views/statistics_view.dart';
import 'views/social_space/social_space_view.dart';
import 'views/account/my_profile_view.dart';

// Secondary Views
import 'views/plans/edit_training_view.dart';
import 'views/account/sso_view.dart';

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
        '/': (context) => const LoginView(),
        '/home': (context) => const HomeView(),
        '/app': (context) => App(currentIndex: 0),
        '/myWorkoutPlans': (context) => const PlanOverview(),
        '/myStatistics': (context) => const StatisticsView(),
        '/socialSpace': (context) => const SocialSpaceView(),
        '/myProfile': (context) => const ProfileView(),
        '/testEditPlan': (context) =>
            EditPlanView(trainingPlan: TrainingPlan.fromJSON({}))
      },
    );
  }
}
