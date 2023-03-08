import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tromega/data/account_signin_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/views/account/add_my_data_view.dart';

//GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  late AccountHttpHelper accountHttpHelper;
  //GoogleSignInAccount? _currentUser;
  late SharedPreferences prefs;

  void handleSignIn() async {
    await _googleSignInService.signIn();
    SharedPreferences.getInstance().then((prefs) {
      _googleSignInService.user?.authentication.then((value) {
        print("token: $value.accessToken");
        prefs.setString('token', value.accessToken ?? '');
      });
      prefs.setString('googleId', _googleSignInService.user?.id ?? '');
      print(_googleSignInService.user?.id);
      accountHttpHelper
          .accountExist(_googleSignInService.user?.id ?? '')
          .then((exists) {
        if (exists) {
          print('exists');
          accountHttpHelper
              .getAccount(_googleSignInService.user?.id ?? '')
              .then((account) {
            print("userId: $account.id");
            prefs.setString('userId', account.getId());
          });
          Navigator.of(context).pushNamed('/app');
        } else {
          print("failed");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddMyDataView(
                    googleId: _googleSignInService.user?.id ?? '',
                  )));
        }
      });
    });
  }

  void initState() {
    super.initState();
    accountHttpHelper = AccountHttpHelper();
  }

  /*
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
      _googleSignIn.signInSilently();

    '_googleSignIn.isSignedIn().then((value) {
      print("Value!");
      print(value);
    });
  }
  */

  /*Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      SharedPreferences.getInstance().then((prefs) {
        _currentUser?.authentication.then((value) {
          print("token: $value.accessToken");
          prefs.setString('token', value.accessToken ?? '');
        });
        prefs.setString('googleId', _currentUser?.id ?? '');
        print(_currentUser?.id);
        accountHttpHelper.accountExist(_currentUser?.id ?? '').then((exists) {
          if (exists) {
            print('exists');
            accountHttpHelper
                .getAccount(_currentUser?.id ?? '')
                .then((account) {
              print("userId: $account.id");
              prefs.setString('userId', account.getId());
            });
            Navigator.of(context).pushNamed('/app');
          } else {
            print("failed");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddMyDataView(
                      googleId: _currentUser?.id ?? '',
                    )));
          }
        });
      });
    } catch (error) {
      print(error);
    }
  }
  */

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton.icon(
        icon: const FaIcon(
          FontAwesomeIcons.google,
          //color: Color.fromARGB(1000, 240, 157, 2)
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 50),
          maximumSize: const Size(200, 50),
          primary: Color.fromARGB(1000, 0, 48, 80),
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
          _buildBody()
        ],
      ),
    );
  }
}
