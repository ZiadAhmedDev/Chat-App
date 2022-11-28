import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Pages/Login_Page.dart';
import '../Constants.dart';
import '../Widget/Custom_Botton.dart';
import '../Widget/Custom_TextField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/Snack_Bar.dart';
import 'Chat_Page.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  static String id = 'SignUpPage';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? emailAddress;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();
  bool isProHud = false;
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
                      'Sign UP',
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
                  text: 'Sign UP',
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isProHud = true;
                      setState(() {});
                      try {
                        await signUpUser();
                        // Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          snackBarMessage(context, 'The Password is weak');
                        } else if (e.code == 'email-already-in-use') {
                          snackBarMessage(
                              context, 'The Email is already in used');
                        }
                      } catch (e) {
                        snackBarMessage(
                            context, 'There is an error, Please try again');
                      }
                      isProHud = false;
                      setState(() {});
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'LOGIN',
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
}

Future<void> signUpUser() async {
  UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress!,
    password: password!,
  );
}
