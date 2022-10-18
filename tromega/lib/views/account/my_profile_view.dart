import 'package:flutter/material.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/data/acoount_http_helper.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/account/profile_widget.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Account account;
  late Body body;
  late AccountHttpHelper accountHttpHelper;

  @override
  initState() {
    accountHttpHelper = AccountHttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: 'https://media.istockphoto.com/photos/close-up-photo-beautiful-amazing-she-her-lady-look-side-empty-space-picture-id1146468004?k=20&m=1146468004&s=612x612&w=0&h=oCXhe0yOy-CSePrfoj9d5-5MFKJwnr44k7xpLhwqMsY=',
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
            account.name,
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
          buildDataRow(text1: 'Alter', text2: account.birthdate),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Größe', text2: "${body.height} m"),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Gewicht', text2: "${body.weight} kg"),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Geschlecht', text2: account.sex),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Trainingsziel', text2: "Muskeln aufbauen")
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

