import 'package:flutter/material.dart';
import '../widgets/bottom_menu.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hier Icon einfügen')),
      body: const Text('Maiks\' ToDo'),
      bottomNavigationBar: const BottomMenu(
        index: 0
      ),
    );
  }
}