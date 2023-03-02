import 'package:flutter/material.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/shared/app_bar.dart';

class SocialSpaceView extends StatelessWidget {
  const SocialSpaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: const Text('NTH but we\'ll see'),
    );
  }
}
