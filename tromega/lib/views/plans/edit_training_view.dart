import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/app_bar.dart';

class EditPlanView extends StatelessWidget {
  const EditPlanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(),
      body: const Text('Steffens\' ToDo'),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }
}
