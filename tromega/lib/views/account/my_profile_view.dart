import 'package:flutter/material.dart';
import 'package:tromega/views/account/Example/user.dart';
import 'package:tromega/views/account/edit_profile_view.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/account/profile_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = User(
        'https://media.istockphoto.com/photos/close-up-photo-beautiful-amazing-she-her-lady-look-side-empty-space-picture-id1146468004?k=20&m=1146468004&s=612x612&w=0&h=oCXhe0yOy-CSePrfoj9d5-5MFKJwnr44k7xpLhwqMsY=',
        'John Doe',
        20,
        1.80,
        70,
        "männlich",
        "Muskeln aufbauen");
    return Scaffold(
      appBar: AppBar_Icon(),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EditProfile()));
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          buildData(user),
        ],
      ),
      bottomNavigationBar: const BottomMenu(index: 4),
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
          buildDataRow(text1: 'Alter', text2: "${user.age}"),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Größe', text2: "${user.height} m"),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Gewicht', text2: "${user.weight} kg"),
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
