// Matthias

import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';

class TrackingView extends StatelessWidget {
  const TrackingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hier Icon einfügen')),
      body: const Text('Matthias\' ToDo'),
    );
  }
}