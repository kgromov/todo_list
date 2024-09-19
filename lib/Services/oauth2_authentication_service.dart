import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Oauth2AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Oauth2AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User> signIn() async {
    try {
      var googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw 'Sign in error: no account';
      }
      final GoogleSignInAuthentication authentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      var user = authResult.user;
      print('User details: $user');
      if (user == null || user.isAnonymous) {
        throw 'Sign in error: user not found';
      }
      var token = await user.getIdToken();
      if (token == null) {
        throw 'Sign in error: no token';
      }
      var currentUser = _firebaseAuth.currentUser;
      print('User details: $currentUser');
      if (currentUser == null || currentUser.uid != user.uid) {
        throw 'Sign in error: current user mismatch';
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? '';
    }
  }
}