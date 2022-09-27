import 'package:tromega/views/account/profile_widget.dart';
import 'package:tromega/views/account/textfield_widget.dart';

import '../../widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'Example/user_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final user = UserPreferneces.myUser;
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
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Voller Name', text: user.name, onChanged: (name) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Alter', text: user.age, onChanged: (age) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Height', text: user.height, onChanged: (height) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Weight', text: user.weight, onChanged: (weight) {}),
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
