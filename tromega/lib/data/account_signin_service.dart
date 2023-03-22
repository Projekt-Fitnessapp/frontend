import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Erstellt von Rebekka Miguez//

class GoogleSignInService {
  //Google Services für die SSO

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Aktueller eingeloggter User
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  //User einloggen
  Future<bool> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _user = account;
      return (true);
    } catch (error) {
      debugPrint('Failed to sign in with Google: $error');
      return (false);
    }
  }

  //User ausloggen
  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      _user = null;
      return (true);
    } catch (error) {
      debugPrint('Failed to sign out from Google: $error');
      return (false);
    }
  }

  
}
