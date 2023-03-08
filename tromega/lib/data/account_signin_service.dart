import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _user = account;
    } catch (error) {
      print('Failed to sign in with Google: $error');
    }
  }

  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      _user = null;
    } catch (error) {
      print('Failed to sign out from Google: $error');
    }
  }
}
