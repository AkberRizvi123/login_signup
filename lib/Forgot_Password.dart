import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final email_controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    email_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Password Recovery"),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Password Recovery",
                textScaleFactor: 2,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Enter Your Email Address for Password Recovery"),
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
                      return "Please Enter Your Email ";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
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
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    child: const Text("Reset Password"),
                    onPressed: () {
                      setState(() {
                        if (_formkey.currentState!.validate()) {
                          verifyEmail(context, email_controller.text.trim());
                        }
                      });
                    }),
              ),
            ],
          ))),
    );
  }
}

Future verifyEmail(context, email) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    const Text("Password Reset Email sent");
    Navigator.of(context).popUntil((route) => route.isFirst);
  } on FirebaseAuthException catch (e) {
    Text(e.toString());
    print(e.toString());
    Navigator.of(context).pop();
  }
}
