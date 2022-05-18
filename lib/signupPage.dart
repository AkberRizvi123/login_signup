import 'package:flutter/material.dart';
import 'package:login_signup/loginPage.dart';
import 'package:login_signup/signupPage2.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final CPassword_controller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    CPassword_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Signup"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Register Your Account",
                  textScaleFactor: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Complete the following details to register yourself"),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      labelText: "Email",
                      hintText: "Enter Your Email",
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
                  height: 30,
                ),
                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      labelText: "Password",
                      hintText: "Enter Your Password",
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
                        return "Please Enter Your Password";
                      }
                      if (!regex.hasMatch(value)){
                        return "Please Enter Valid Password(Min. 6 Character";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      password_controller.text = text;
                    }),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      labelText: "Confirm Password",
                      hintText: "Confirm Your Password",
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
                        return "Please Confirm Your Password";
                      }
                      if (!regex.hasMatch(value)){
                        return "Please Enter Valid Password(Min. 6 Character";
                      }

                      if (password_controller.text !=
                          CPassword_controller.text) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      CPassword_controller.text = text;
                    }),

                const SizedBox(
                  height: 40,
                ),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      child: const Text("Continue"),
                      onPressed: () {
                        setState(() {
                          if (_formkey.currentState!.validate()) {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage2(email: email_controller.text.trim(), password: password_controller.text.trim())),
                              );

                          }
                        });
                      }),
                ),
                const SizedBox(
                  height: 10,
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
