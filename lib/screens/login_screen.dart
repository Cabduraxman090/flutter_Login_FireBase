import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/home.dart';
import 'package:flutter_login_app/screens/signup_screen.dart';
import 'package:flutter_login_app/services/firebase_auth_service.dart';
import 'package:flutter_login_app/widgets/customized_button.dart';
import 'package:flutter_login_app/widgets/customized_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
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
                    "Welcome Back! Glad \nto see you Again!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomizedTextfield(
                  myController: _emailController,
                  hintText: 'Enter your Email',
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xff6a707c),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                CustomizedButton(
                    buttonText: "Login",
                    buttonColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        await FirebaseAuthService().login(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Home()));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                  "Invalid Username or Password, Please register again or make sure that username and password is correct."),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()));
                                  },
                                  child: Text("Register Now"),
                                ),
                              ],
                            ),
                          );
                        }
                      } on FirebaseException catch (e) {
                        print(e.message);
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.18,
                        color: Colors.grey,
                      ),
                      Text(" Or Login With "),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            //color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.apple,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Dont't have an account?",
                        style: TextStyle(
                          color: Color(0xff6a707c),
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        " Register Now",
                        style: TextStyle(
                          color: Color(0xff35c2c1),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
