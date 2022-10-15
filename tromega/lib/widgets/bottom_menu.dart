import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

@immutable
class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CurvedNavigationBar(
          index: index,
          letIndexChange: (index) => true,
          backgroundColor: Theme.of(context).backgroundColor,
          color: Theme.of(context).primaryColor,
          buttonBackgroundColor: Theme.of(context).primaryColor,
          items: const [
            Icon(Icons.house_rounded, color: Colors.white),
            Icon(Icons.calendar_month, color: Colors.white),
            Icon(
              Icons.show_chart_sharp,
              color: Colors.white,
            ),
            Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ],
          onTap: (int index) {
            String view = '';
            switch (index) {
              case 0:
                view = '/home';
                break;
              case 1:
                view = '/myWorkoutPlans';
                break;
              case 2:
                view = '/myStatistics';
                break;
              case 3:
                view = '/socialSpace';
                break;
              case 4:
                view = '/myProfile';
                break;
            }
            String? currentView = ModalRoute.of(context)?.settings.name;
            if (currentView != view) {
              Navigator.popAndPushNamed(context, view);
            }
          }),
    );
  }
}
