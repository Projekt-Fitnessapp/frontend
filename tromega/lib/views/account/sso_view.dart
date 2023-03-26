//Erstellt von Rebekka Miguez//

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tromega/data/account_signin_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tromega/data/http_helper.dart';
import 'package:tromega/views/account/add_my_data_view.dart';

class LoginView extends StatefulWidget {
  //Erste View zum Einloggen mit SSO

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  late HttpHelper httpHelper;
  late SharedPreferences prefs;

  @override
  void initState() {
    checkForUser();
    super.initState();
    httpHelper = const HttpHelper();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("public/TrOmega_dark.png"), context);
    super.didChangeDependencies();
  }

  void handleSignIn() async {
    //Einloggen
    await _googleSignInService.signIn()
        ? showInSnackbar(context, "Login erfolgreich", false)
        : showInSnackbar(context, "Login gescheitert", true);
    SharedPreferences.getInstance().then((prefs) {
      _googleSignInService.user?.authentication.then((value) {
        prefs.setString('token', value.accessToken ?? '');
      });
      prefs.setString('googleId', _googleSignInService.user?.id ?? '');
      //Prüfung ob der Account bereits existiert
      httpHelper
          .accountExist(_googleSignInService.user?.id ?? '')
          .then((exists) {
        if (exists) {
          httpHelper
              .getAccountWithGoogleId(_googleSignInService.user?.id ?? '')
              .then((account) {
            prefs.setString('userId', account.getId());
            //Navigation zur Home View
            Navigator.of(context).pushNamed('/app');
          });
        } else {
          //Navigation zur einmaligen Registrierung
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddMyDataView(
                    googleId: _googleSignInService.user?.id ?? '',
                  )));
        }
      });
    });
  }

  Widget signUpButton() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton.icon(
        icon: const FaIcon(
          FontAwesomeIcons.google,
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 50),
          maximumSize: const Size(200, 50),
          primary: const Color.fromARGB(1000, 0, 48, 80),
        ),
        onPressed: handleSignIn,
        label: const Text(
          'Sign Up with Google',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Image.asset(
              'public/TrOmega_dark.png',
            ),
          ),
          const SizedBox(height: 24),
          signUpButton()
        ],
      ),
    );
  }

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

  //Prüfung, ob User noch angemeldet ist
  void checkForUser() async {
    prefs = await SharedPreferences.getInstance();
    //Navigation HomeView
    prefs.containsKey("userId") && prefs.containsKey("googleId")
        ? Navigator.of(context).pushNamed('/app')
        : "";
  }
}
