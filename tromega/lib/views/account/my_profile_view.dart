import 'package:flutter/material.dart';
import 'package:tromega/views/account/Example/user_preferences.dart';
import 'package:tromega/views/account/Example/user.dart';
import 'package:tromega/views/account/edit_profile_view.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/app_bar.dart';
import '../account/profile_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const user = UserPreferneces.myUser;
    return Scaffold(
      appBar: AppBar_Icon(),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const EditProfile()));
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          buildData(user),
        ],
      ),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xff003050)),
          ),
        ],
      );

  Widget buildData(User user) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          buildDataRow(text1: 'Alter', text2: user.age),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Größe', text2: user.height),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Gewicht', text2: user.weight),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Geschlecht', text2: user.gender),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Trainingsziel', text2: user.goal)
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
