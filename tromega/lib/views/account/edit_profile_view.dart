import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/data/userAccount.dart';
import '../../widgets/account/profile_widget.dart';
import '../../widgets/account/textfield_widget.dart';

import '../../widgets/shared/app_bar.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
   EditProfile({Key? key, required this.userAccount, required this.body});
  UserAccount userAccount;
  Body body;
  late AccountHttpHelper accountHttpHelper;
  late UserAccount userAccountExample = userAccount;
  late Body bodyExample = body;

  @override
  _EditProfile createState() => _EditProfile();

  onInit() {
    accountHttpHelper = AccountHttpHelper();
  }

}

class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar_Icon(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileWidget(
              imagePath: widget.userAccountExample.imagePath,
              isEdit: true,
              onClicked: () {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Voller Name', text: widget.userAccountExample.name, onChanged: (name) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Alter', text: widget.userAccountExample.birthdate, onChanged: (age) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Height',
                text: "${widget.bodyExample.height} m",
                onChanged: (height) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Weight',
                text: "${widget.bodyExample.weight} kg",
                onChanged: (weight) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Gender', text: widget.userAccount.sex, onChanged: (gender) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Fitness Goal', text: widget.userAccount.goal, onChanged: (goal) {})
          ],
        ),
      );
}
