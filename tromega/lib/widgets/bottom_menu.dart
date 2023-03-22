// Author: Steffen

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

@immutable
class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key, required this.index, required this.onSelectTab})
      : super(key: key);
  final int index;
  final Function onSelectTab;

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
            Icon(Icons.list, color: Colors.white),
            Icon(
              Icons.line_axis,
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
