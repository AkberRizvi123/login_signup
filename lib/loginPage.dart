import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/Forgot_Password.dart';
import 'package:login_signup/profile_page.dart';
import 'package:login_signup/SignupPage.dart';
import 'package:login_signup/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
 final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Login",
                  textScaleFactor: 2,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),

                const Text("Complete the details or continue with social media "),

                const SizedBox(
                  height: 50,
                ),

                TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter Your Email",
                      icon: const Icon(Icons.email),
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
                        return "Please Enter Your Email";
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return "Please Enter a valid email";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      email_controller.text = text;
                    }),

                const SizedBox(

                  height: 50,
                ),

                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter Your Password",
                      icon: const Icon(Icons.lock),
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
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Password is required for login";
                      }
                      if (!regex.hasMatch(value)){
                        return "Please Enter Valid Password(Min. 6 Character)";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      password_controller.text = text;
                    }),

                const SizedBox(
                  height: 30,
                ),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () {

                           Signin();


                        }
                      ),
                ),

                // const SizedBox(
                //   height: 20,
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordRecovery()),
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),

                // const SizedBox(
                //   height: 20,
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()),
                          );

                      },
                      child: const Text("Signup", textScaleFactor: 1.2),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    onPrimary: Colors.white,
                  ),
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text("Signup with Google"),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

                    provider.googleLogin();
                  },
                ),

                // const CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: AssetImage("assets/images/google.png"),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }


void Signin() async {
  if (_formkey.currentState!.validate()) {
    await _auth.signInWithEmailAndPassword(
        email: email_controller.text, password: password_controller.text).then((uid) {
          Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ProfilePage()),
      ).catchError((error){
         Fluttertoast.showToast(msg: error!.toString());
      });

      });

  }
 }
}