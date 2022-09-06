import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';

class PlanOverview extends StatelessWidget {
  const PlanOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hier Icon einfügen')),
      body: const Text('Binhs\' ToDo'),
      bottomNavigationBar: const BottomMenu(
        index: 1
      ),
    );
  }
}