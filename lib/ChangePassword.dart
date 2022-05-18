import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/LoginPage.dart';

import 'models/user_model.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _auth = FirebaseAuth.instance;

  final  OPassword_controller= TextEditingController();
  final  Password_controller= TextEditingController();
  final  CPassword_controller= TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    OPassword_controller.dispose();
    Password_controller.dispose();
    CPassword_controller.dispose();
    super.dispose();
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinuser = UserModel();
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value){
      this.loggedinuser = UserModel.fromMap(value.data());
      setState((){});

    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Password Recovery"),
          ),
          body: SingleChildScrollView(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("Change Password",
                      textScaleFactor: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),


                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          labelText: "Old Password",
                          hintText: "Enter Your Old Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 42,vertical: 20),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color:Colors.black12),
                            gapPadding: 10,

                          ),

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Old Your Password";
                          }
                          if(validatePassword()==false){
                            return "Incorrect Password";
                          }
                          return null;
                        },
                        onChanged: (text){
                          OPassword_controller.text=text;
                        }
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          labelText: "Password",
                          hintText: "Enter Your new Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 42,vertical: 20),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color:Colors.black12),
                            gapPadding: 10,

                          ),

                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Please Enter Your new Password";
                          }
                          if (!regex.hasMatch(value)){
                            return "Please Enter Valid Password(Min. 6 Character";
                          }
                          return null;
                        },
                        onChanged: (text){
                          Password_controller.text=text;
                        }
                    ),

                    const SizedBox(
                      height: 30,

                    ),
                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            labelText: "Confirm Password",
                            hintText: "Confirm Your new Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 42,vertical: 20),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: const BorderSide(color:Colors.black12),
                              gapPadding: 10,

                            )

                        ),
                        validator: (value){
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if(value!.isEmpty){
                            return "Please confirm Your Password";
                          }
                          if(Password_controller.text!=CPassword_controller.text){
                            return "Passwords don't match";
                          }
                          if (!regex.hasMatch(value)){
                            return "Please Enter Valid Password(Min. 6 Character";
                          }
                          return null;
                        },
                        onChanged: (text){
                          CPassword_controller.text=text;
                        }
                    ),
                    const SizedBox(
                      height: 30,

                    ),

                    SizedBox(
                      width: 200,
                      child: ElevatedButton(

                          child: const Text("Submit"),

                          onPressed: () {
                            setState(() {
                              if(_formkey.currentState!.validate()){
                                user!.updatePassword(Password_controller.text.trim());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              }

                            });

                          }
                      ),
                    ),

                  ],
                )
            ),
          )
      ),
    );

  }
  Future<bool> validatePassword() async {
    var firebaseUser = await _auth.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser!.email.toString(), password: OPassword_controller.text.trim());
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
