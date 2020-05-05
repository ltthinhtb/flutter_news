import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_news/service/database.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _facebooklogin = FacebookLogin();
  bool isLoggedIn = false;
  SharedPreferences prefs;
  FirebaseUser currentUser;

  Future<Null> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    prefs = await SharedPreferences.getInstance();
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseUser firebaseUser =
        (await _auth.signInWithCredential(credential)).user;
    currentUser = firebaseUser;
    await prefs.setString('userId', currentUser.uid);
    await prefs.setBool('islogin', true);
    await DataBase(uid: currentUser.uid).userCreate(
        currentUser.displayName, currentUser.displayName, currentUser.email);
  }

  Future loginWithFacebook() async {
    final result = await _facebooklogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      );
      final user = (await _auth.signInWithCredential(credential)).user;
      currentUser = user;
      await prefs.setString('userId', currentUser.uid);
      await prefs.setBool('islogin', true);
      await DataBase(uid: currentUser.uid).userCreate(
          currentUser.displayName, currentUser.displayName, currentUser.email);
      await DataBase(uid: currentUser.uid).updateAvatar(currentUser.photoUrl);
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> SignInWithEmail(String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    print(user.displayName);
//    await prefs.setString('id', user.uid);
//    await prefs.setString('nickname', user.displayName);
//    await prefs.setString('photoUrl', user.photoUrl);
//    await prefs.setString('email', user.email);
    await prefs.setString('userId', user.uid);
    await prefs.setBool('islogin', true);
  }

  Future<String> signUpWithEmail({String email, String password}) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    String id = user.uid;
    _auth.signOut();
    return id;
  }

  Future<void> signOut() async {
    prefs = await SharedPreferences.getInstance();
    _auth.signOut();
    _googleSignIn.signOut();
    _facebooklogin.logOut();
    await prefs.setBool('islogin', false);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<bool> checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.getBool('islogin') ?? false);
    return isLogin;
  }
}
