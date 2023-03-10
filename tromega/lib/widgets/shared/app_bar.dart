import 'package:flutter/material.dart';

class AppBar_Icon extends StatelessWidget with PreferredSizeWidget {
  AppBar_Icon({Key? key, required this.actions, this.withBackButton = true})
      : super(key: key);
  final List<Widget> actions;
  final bool withBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      automaticallyImplyLeading: withBackButton,
      title: Image.asset('public/TrOmega_logo.png',
          fit: BoxFit.cover, height: 32, alignment: Alignment.center),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
