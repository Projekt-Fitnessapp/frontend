import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/data/body.dart';
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
  late Account lastAccount;
  late Body lastBody;
  late AccountHttpHelper accountHttpHelper;

  @override
  void initState() {
    accountHttpHelper = AccountHttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar_Icon(actions: []),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileWidget(
              imagePath: 'https://media.istockphoto.com/photos/close-up-photo-beautiful-amazing-she-her-lady-look-side-empty-space-picture-id1146468004?k=20&m=1146468004&s=612x612&w=0&h=oCXhe0yOy-CSePrfoj9d5-5MFKJwnr44k7xpLhwqMsY=',
              isEdit: true,
              onClicked: () {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Voller Name', text: lastAccount.name, onChanged: (name) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Alter', text: "20", onChanged: (age) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Height',
                text: "${lastBody.height} m",
                onChanged: (height) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Weight',
                text: "${lastBody.weight} kg",
                onChanged: (weight) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Gender', text: lastAccount.sex, onChanged: (gender) {}),
            const SizedBox(height: 24),
            TextFieldWidget(
                label: 'Fitness Goal', text: "Muskeln aufbauen", onChanged: (goal) {})
          ],
        ),
      );

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Account account = await accountHttpHelper.getAccount(prefs.getString('userId') ?? '');
    Body body = await accountHttpHelper.getBody(prefs.getString('userId') ?? '');

    setState(() {
      lastAccount = account;
      lastBody = body;
    });
  }
}
