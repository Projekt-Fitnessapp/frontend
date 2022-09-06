import 'package:flutter/material.dart';

class AppBar_Icon extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Image.asset('public/TrOmega_logo.png',
          fit: BoxFit.cover, height: 32, alignment: Alignment.center),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
