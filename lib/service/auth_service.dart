import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_news/service/database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Map userProfile;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final facebookLogin = FacebookLogin();
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
    DataBase(uid: currentUser.uid).getToken();
  }

  // ignore: non_constant_identifier_names
  Future<void> SignInWithEmail(String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    print(user.displayName);
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

  Future<bool> loginFb() async {
    prefs = await SharedPreferences.getInstance();
    bool isLoginFB = false;
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(1000).height(1000),email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        userProfile = profile;
        await prefs.setString('userId', userProfile['id']);
        await prefs.setBool('islogin', true);
        await DataBase(uid: userProfile['id']).userCreate(
            userProfile['name'], userProfile['name'], userProfile['email']);
        await DataBase(uid: userProfile['id']).updateAvatar(userProfile['picture']['data']['url']);
        DataBase(uid: userProfile['id']).getToken();
        isLoginFB = true;
        break;
      case FacebookLoginStatus.cancelledByUser:
        isLoginFB = false;
        break;
      case FacebookLoginStatus.error:
        isLoginFB = false;
        break;
    }
    return isLoginFB;
  }

  Future<void> signOut() async {
    prefs = await SharedPreferences.getInstance();
    _auth.signOut();
    _googleSignIn.signOut();
     facebookLogin.logOut();
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
