// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/ChangePassword.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/google_signin.dart';
import 'package:login_signup/models/user_model.dart';
import 'package:provider/provider.dart';


class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({Key? key}) : super(key: key);

  @override
  _ProfilePage2State createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {


  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),

            Text(
              "Welcome ${user.displayName}",
              textScaleFactor: 2,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children:[
                  Expanded(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.signOutGoogle(context);


                },
                child: Row(
                  children: const [
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
