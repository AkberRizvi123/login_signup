// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_signup/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/google_signin.dart';
import 'package:login_signup/models/user_model.dart';
import 'package:provider/provider.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinuser = UserModel();

  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value){
      this.loggedinuser = UserModel.fromMap(value.data());
      setState((){});

      });
  }

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
              "Welcome ${loggedinuser.firstname } ${loggedinuser.lastname}",
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
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://pbs.twimg.com/media/Eu7e3mQVgAImK2o?format=png&name=large"),
                    backgroundColor: Colors.white,
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
                onPressed: () {},
                child: Row(
                  children: const [
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "My Account",
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

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //
            // ),
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
                  provider.logout(context);


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
