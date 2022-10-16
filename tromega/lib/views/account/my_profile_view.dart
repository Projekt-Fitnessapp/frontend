import 'package:flutter/material.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/data/userAccount.dart';
import 'package:tromega/views/account/edit_profile_view.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/account/profile_widget.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key, required this.userAccount, required this.body})
      : super(key: key);
  UserAccount userAccount;
  Body body;
  late AccountHttpHelper accountHttpHelper;
  late UserAccount userAccountExample = userAccount;
  late Body bodyExample = body;

  @override
  State<ProfileView> createState() => _ProfileViewState();

  onInit() {
    accountHttpHelper = AccountHttpHelper();
  }
}

class _ProfileViewState extends State<ProfileView> {
  onInit() {
    print(widget.userAccountExample);
    print(widget.bodyExample);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: widget.userAccountExample.imagePath,
            onClicked: () {
              Navigator.pushNamed(context, '/editProfile');
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          buildData(),
        ],
      ),
      bottomNavigationBar: const BottomMenu(index: 4),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            widget.userAccountExample.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xff003050)),
          ),
        ],
      );

  Widget buildData() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          buildDataRow(
              text1: 'Alter', text2: widget.userAccountExample.birthdate),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Größe', text2: "${widget.bodyExample.height} m"),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Gewicht', text2: "${widget.bodyExample.weight} kg"),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Geschlecht', text2: widget.userAccountExample.sex),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Trainingsziel', text2: widget.userAccountExample.goal),
        ],
      ));

  Widget buildDataRow({required String text1, text2}) => Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Text(text1, style: const TextStyle(fontSize: 16)),
            ),
            Expanded(
              flex: 5,
              child: Text(text2, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
}
