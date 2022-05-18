import 'package:flutter/material.dart';

import 'SignupPage.dart';
import 'loginPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login/Register"),
       ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login or Signup",
              textScaleFactor: 2,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Choose one of the following to continue "),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: const Text("Signup"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
