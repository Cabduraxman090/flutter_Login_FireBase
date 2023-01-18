import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/login_screen.dart';
import 'package:flutter_login_app/screens/signup_screen.dart';
import 'package:flutter_login_app/widgets/customized_button.dart';

import 'home.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 130,
              width: 180,
              child: Image(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
            CustomizedButton(
              buttonText: "Login",
              buttonColor: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StreamBuilder(
                              stream: FirebaseAuth.instance.authStateChanges(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Home();
                                } else {
                                  return LoginScreen();
                                }
                              },
                            )));
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
            CustomizedButton(
              buttonText: "Register",
              buttonColor: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Continue as a Gest",
                style: TextStyle(color: Color(0xff35c2c1), fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
