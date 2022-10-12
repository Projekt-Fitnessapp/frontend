import 'package:tromega/views/account/Example/user.dart';
import '../../widgets/account/profile_widget.dart';
import '../../widgets/account/textfield_widget.dart';

import '../../widgets/shared/app_bar.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final user = User(
      'https://media.istockphoto.com/photos/close-up-photo-beautiful-amazing-she-her-lady-look-side-empty-space-picture-id1146468004?k=20&m=1146468004&s=612x612&w=0&h=oCXhe0yOy-CSePrfoj9d5-5MFKJwnr44k7xpLhwqMsY=',
      'John Doe',
      20,
      1.80,
      70,
      "männlich",
      "Muskeln aufbauen");
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar_Icon(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Voller Name', text: user.name, onChanged: (name) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Alter', text: "${user.age}", onChanged: (age) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Height',
                text: "${user.height} m",
                onChanged: (height) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Weight',
                text: "${user.weight} kg",
                onChanged: (weight) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Gender', text: user.gender, onChanged: (gender) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Fitness Goal', text: user.goal, onChanged: (goal) {})
          ],
        ),
      );
}
