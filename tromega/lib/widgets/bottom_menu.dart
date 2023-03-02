import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

@immutable
class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key, required this.index, required this.onSelectTab})
      : super(key: key);
  final int index;
  final onSelectTab;

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
            onSelectTab(index);
          }),
    );
  }
}
