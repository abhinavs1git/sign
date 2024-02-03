// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign/reusable_widgets/reusable_widget.dart';
import 'package:sign/screens/home_screen.dart';
import 'package:sign/screens/reset_password.dart';
import 'package:sign/screens/signup_screen.dart';
import 'package:sign/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  String? _errorText; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("AA4B6B"),
          hexStringToColor("6B6B83"),
          hexStringToColor("3B8D99")
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    child: Icon(
                      Icons.code_rounded,
                      size: 100,
                      color: Colors.white.withOpacity(01),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Developer Quiz",
                    style: TextStyle(
                        color: Colors.white.withOpacity(1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                if (_errorText != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _errorText!,
                      style: TextStyle(fontSize:16,color: Colors.white.withRed(180)),
                    ),
                  ),
                firebaseUIButton(context, "Sign In", () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    );
                    
                    // Successful login
                     setState(() {
                      _errorText = null;
                     });
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  } catch (e) {
                    setState(() {
                      _errorText = "Invalid Credentails";
                    });
                  }
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
