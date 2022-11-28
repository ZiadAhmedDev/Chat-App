import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/Chat_Page.dart';
import 'firebase_options.dart';
import 'Pages/Login_Page.dart';
import 'Pages/SignUp_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SignUp.id: (context) => SignUp(),
          ChatPage.id: (context) => ChatPage(),
        },
        home: const LoginPage());
  }
}
