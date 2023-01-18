import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/welcome_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(children: [
        Text("Hello i am Home Screen"),
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WelcomeScreen();
              }));
            },
            child: Text("Sign out")),
      ]),
    );
  }
}
