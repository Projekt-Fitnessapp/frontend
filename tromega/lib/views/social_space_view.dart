import 'package:flutter/material.dart';
import '../widgets/bottom_menu.dart';

class SocialSpaceView extends StatelessWidget {
  const SocialSpaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hier Icon einfügen')),
      body: const Text('NTH but we\'ll see'),
      bottomNavigationBar: const BottomMenu(
        index: 3
      ),
    );
  }
}