import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Pages/Chat_Page.dart';
import '../Constants.dart';
import '../Widget/Custom_Botton.dart';
import '../Widget/Custom_TextField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/Snack_Bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String? emailAddress;

String? password;

GlobalKey<FormState> formKey = GlobalKey();
bool isProHud = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isProHud,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: const [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  obscureText: false,
                  hintText: 'Email',
                  onChange: (data) {
                    emailAddress = data;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  obscureText: true,
                  hintText: 'password',
                  onChange: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'LOGIN',
                  ontap: () async {
                    isProHud = true;
                    setState(() {});
                    try {
                      await signInUser();
                      Navigator.pushNamed(context, ChatPage.id,
                          arguments: emailAddress);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        snackBarMessage(
                            context, 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        snackBarMessage(
                            context, 'Wrong password provided for that user.');
                      }
                    } catch (e) {
                      snackBarMessage(context, '$e');
                    }
                    isProHud = false;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?   ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'SignUpPage');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
  }
}
