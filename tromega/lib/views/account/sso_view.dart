import 'dart:async';
import 'dart:convert' show json;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/views/account/add_my_data_view.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AccountHttpHelper account_http_helper;
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    account_http_helper = AccountHttpHelper();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      SharedPreferences.getInstance().then((prefs) {
        _currentUser?.authentication.then((value) {
          print("token: $value.accessToken");
          prefs.setString('token', value.accessToken ?? '');
        });
        account_http_helper.accountExist(_currentUser?.id ?? '').then((exists) {
          if (exists) {
            account_http_helper
                .getAccount(_currentUser?.id ?? '')
                .then((account) {
              print("userId: $account.id");
              prefs.setString('userId', account.id);
            });

            Navigator.pushNamed(context, '/home');
          } else {
            print("failed");
            _currentUser?.authentication.then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddMyDataView(
                        googleId: _currentUser?.id ?? '',
                      )));
            });
          }
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.disconnect();
    } catch (error) {
      print(error);
    }
    setState(() {});
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
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
          onPressed: _handleSignIn,
          label: const Text(
            'Sign Up with Google',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
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
