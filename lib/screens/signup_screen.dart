import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/services/firebase_auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/customized_button.dart';
import '../widgets/customized_textfield.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_sharp),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Hello! Register to get \nstarted",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                    child: Text(_msgController.text.trim(),
                        style: TextStyle(color: Colors.red))),
                CustomizedTextfield(
                  myController: _usernameController,
                  hintText: 'Username',
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _emailController,
                  hintText: 'Email',
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                ),
                CustomizedTextfield(
                  myController: _confirmPasswordController,
                  hintText: 'Confirm password',
                  isPassword: true,
                ),
                CustomizedButton(
                  buttonText: "Register",
                  buttonColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      if (_passwordController.text.trim() ==
                          _confirmPasswordController.text.trim()) {
                        await FirebaseAuthService().signup(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
                      } else {
                        _msgController.text = "Confirm Password";
                      }
                    } on FirebaseException catch (e) {
                      _msgController.text = e.message.toString();
                      print(e.message);
                    }

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                ),
                const Expanded(
                  child: SizedBox(
                    height: 40,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
