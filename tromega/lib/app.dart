import 'package:flutter/material.dart';
import 'package:tromega/views/account/my_profile_view.dart';
import 'package:tromega/views/home_view.dart';
import 'package:tromega/views/plans/plan_overview.dart';
import 'package:tromega/views/social_space_view.dart';
import 'package:tromega/views/statistics_view.dart';
import 'package:tromega/widgets/bottom_menu.dart';

class App extends StatefulWidget {
  int currentIndex;
  @override
  State<StatefulWidget> createState() => AppState();
  App({Key? key, required this.currentIndex}) : super(key: key);
}

class AppState extends State<App> {
  late Widget view = selectWidget();
  var fetching = true;

  @override
  initState() {
    super.initState();
  }

  void _selectTab(int index) {
    setState(() {
      widget.currentIndex = index;
      view = selectWidget();
      selectWidget();
    });
  }

  Widget selectWidget() {
    if (widget.currentIndex == 0) {
      return HomeView(onSelectTab: _selectTab);
    } else if (widget.currentIndex == 1) {
      return const PlanOverview();
    } else if (widget.currentIndex == 2) {
      return const StatisticsView();
    } else if (widget.currentIndex == 3) {
      return const SocialSpaceView();
    } else {
      return const ProfileView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view,
      bottomNavigationBar: BottomMenu(
        index: widget.currentIndex,
        onSelectTab: _selectTab,
      ),
    );
  }
}
