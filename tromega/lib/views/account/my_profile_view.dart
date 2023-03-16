import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tromega/data/account_signin_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/classes/account.dart';
import 'package:tromega/data/classes/body.dart';
import 'package:tromega/data/http_helper.dart';
import '../../data/classes/benchmarking.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/account/profile_widget.dart';
import 'package:intl/intl.dart';

import 'edit_benchmarking.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  late Account lastAccount;
  late Body lastBody;
  late Map<String, dynamic> lastPushUps;
  late Map<String, dynamic> lastPullUps;
  late Map<String, dynamic> lastSquads;
  late Map<String, dynamic> lastCrunches;
  late HttpHelper httpHelper;
  late SharedPreferences prefs;
  bool fetching = true;

  @override
  void initState() {
    httpHelper = const HttpHelper();
    fetchData();
    super.initState();
  }

  void handleSignOut() async {
    await _googleSignInService.signOut().then((value) {
      if (!value) {
        showInSnackbar(context, "Logout gescheitert", true);
      } else {
        showInSnackbar(context, "Logout erfolgreich", false);
        prefs.clear();
        Navigator.pushNamed(context, "/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBarIcon(
        actions: const [],
      ),
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 24),
                ProfileWidget(
                  imagePath:
                      'https://media.istockphoto.com/photos/close-up-photo-beautiful-amazing-she-her-lady-look-side-empty-space-picture-id1146468004?k=20&m=1146468004&s=612x612&w=0&h=oCXhe0yOy-CSePrfoj9d5-5MFKJwnr44k7xpLhwqMsY=',
                  onClicked: () {
                    //Navigator.pushNamed(context, '/editProfile');
                  },
                ),
                const SizedBox(height: 24),
                buildName(),
                const SizedBox(height: 24),
                buildData(),
                const SizedBox(height: 24),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          maximumSize: const Size(200, 50),
                          primary: const Color.fromARGB(1000, 0, 48, 80),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const EditBenchmarking())));
                        },
                        child: const Text(
                          'Benchmarking ändern',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton.icon(
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          maximumSize: const Size(200, 50),
                          primary: const Color.fromARGB(1000, 0, 48, 80),
                        ),
                        onPressed: handleSignOut,
                        label: const Text(
                          'Sign Out',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            lastAccount.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xff003050)),
          ),
        ],
      );

  Widget buildData() {
    DateFormat formatter = DateFormat.yMMMMd('de_DE');
    var formattedDate = formatter.format(lastAccount.birthdate);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          buildDataRow(text1: 'Alter', text2: formattedDate),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Größe', text2: "${lastBody.height.toString()} cm"),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Gewicht', text2: "${lastBody.weight.toString()} kg"),
          const SizedBox(height: 24),
          buildDataRow(text1: 'Geschlecht', text2: lastAccount.sex.toString()),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Liegestütze',
              text2: lastPushUps['exercise_amount'].toString()),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Klimmzüge',
              text2: lastPullUps['exercise_amount'].toString()),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Kniebeugen',
              text2: lastSquads['exercise_amount'].toString()),
          const SizedBox(height: 24),
          buildDataRow(
              text1: 'Crunches',
              text2: lastCrunches['exercise_amount'].toString()),
        ]));
  }

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

  //Snackbar für Alerts
  void showInSnackbar(BuildContext context, String value, bool error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            error ? Colors.red : Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }

  void fetchData() async {
    prefs = await SharedPreferences.getInstance();
    Account account = await httpHelper
        .getAccountWithGoogleId(prefs.getString('googleId') ?? '');
    Body body = await httpHelper.getBody(prefs.getString('userId') ?? '');
        List<dynamic> pushUps = await httpHelper.getBenchmarking("push_ups");
    List<dynamic> pullUps = await httpHelper.getBenchmarking( "pull_ups");
    List<dynamic> squads = await httpHelper.getBenchmarking("squads");
    List<dynamic> crunches = await httpHelper.getBenchmarking("crunches");


    setState(() {
      lastAccount = account;
      lastBody = body;
      lastPushUps = pushUps.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : pushUps.last;
      lastPullUps = pullUps.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : pullUps.last;
      lastSquads = squads.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : squads.last;
      lastCrunches = crunches.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : crunches.last;
      fetching = false;
    });
  }
}
