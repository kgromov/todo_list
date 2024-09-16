import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
   var googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? authentication = await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: authentication?.idToken,
      accessToken: authentication?.accessToken);

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  var user = authResult.user;

  assert(!user!.isAnonymous);
  assert(await user?.getIdToken() != null);

  var currentUser = _auth.currentUser;
  assert(currentUser?.uid == user?.uid);

  return user as User;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
}