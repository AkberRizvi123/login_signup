import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_signup/profile_page.dart';
import 'package:login_signup/signupPage2.dart';

import 'LoginPage.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ]
  );
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text('Something went wrong!'));
            }
            else if(snapshot.hasData){
              return ProfilePage();
            }
            else {
              return LoginPage();
            }
          },
        ),
      );
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    FirebaseAuth.instance.signOut().then((value) {
      print("Signed Out");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage()),
      );
    });
  }
}
