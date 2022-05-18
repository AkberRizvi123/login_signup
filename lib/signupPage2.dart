import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';


class SignupPage2 extends StatefulWidget {
  final String email;
  final String password;
  const SignupPage2({Key? key, required this.email,required this.password}) : super(key: key);

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
                      if (_formkey.currentState!.validate()) {
                        showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => AlertDialog(
                            content: const Text('Registration Successful'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const LoginPage()),
                                    );
                                  });
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      }
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
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: widget.email , password: widget.password)
                            .then((value) {
                          print("Created new Account");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        }).onError((error, stackTrace) {
                          print(error.toString());
                        });

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
}
