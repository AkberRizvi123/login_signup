import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signup/profile_page.dart';
import 'loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user_model.dart';

class SignupPage2 extends StatefulWidget {
  final String email;
  final String password;
  const SignupPage2({required this.email, required this.password});


  @override
  _SignupPage2State createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  final FName_controller = TextEditingController();
  final LName_controller = TextEditingController();
  final phone_controller = TextEditingController();
  final address_controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    FName_controller.dispose();
    LName_controller.dispose();
    phone_controller.dispose();
    address_controller.dispose();
    super.dispose();
  }
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Signup"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Complete Your Profile",
                  textScaleFactor: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Complete the following details "),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: "First Name",
                      hintText: "Enter Your First Name",
                      icon: const Icon(Icons.person),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Colors.black12),
                        gapPadding: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      FName_controller.text = text;
                    }),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      hintText: "Enter Your Last Name",
                      icon: const Icon(Icons.person),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Colors.black12),
                        gapPadding: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      LName_controller.text = text;
                    }),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter Your Phone Number",
                      icon: const Icon(Icons.phone),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Colors.black12),
                        gapPadding: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      phone_controller.text = text;
                    }),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: "Address",
                      hintText: "Enter Your Address",
                      icon: const Icon(Icons.home),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Colors.black12),
                        gapPadding: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      address_controller.text = text;
                    }),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                          signUp();
                    },
                    child: const Text('Register'),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );


                      },
                      child: const Text("Login", textScaleFactor: 1.2),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void signUp() async{

     if (_formkey.currentState!.validate()) {
       await _auth.createUserWithEmailAndPassword(email: widget.email, password:widget.password).then((value) => {
        postDetailsToFirestore()
       }).catchError((e){
         Fluttertoast.showToast(msg: e!.toString());
       });

     }
  }

  postDetailsToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel= UserModel();

    userModel.email= user!.email;
    userModel.uid = user.uid;
    userModel.firstname= FName_controller.text.trim();
    userModel.lastname = LName_controller.text.trim();
    userModel.phone = phone_controller.text.trim();
    userModel.address = address_controller.text.trim();

    await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created Successfully");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) =>
          const ProfilePage()),
        (route) => false);
  }

}
