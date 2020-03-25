import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:tez_bdt/core/helper/shared_manager.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private();

  static GoogleSignHelper get instance => _instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<GoogleSignInAccount> signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  bool get isHaveUser => _googleSignIn.currentUser == null ? false : true;

  Future<GoogleSignInAuthentication> googleAuthentice() async {
    if (await _googleSignIn.isSignedIn()) {
      final user = _googleSignIn.currentUser;
      final userData = await user.authentication;
      print(userData.accessToken);
      return userData;
    }

    return null;
  }

//Google hesabından çıkış için kullanılıyor
  Future<GoogleSignInAccount> SignOut() async {
    final user = await _googleSignIn.signOut();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<FirebaseUser> FirebaseSignIn() async {
    final GoogleSignInAuthentication googleAuth = await googleAuthentice();

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("Signed in " + user.displayName);
    var tokenresult = await user.getIdToken();
     
    await SharedManager.instance
        .saveString(SharedKeys.TOKEN, tokenresult.token);
    
    return user;
  }
}
