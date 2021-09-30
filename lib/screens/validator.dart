import 'package:date_dif/screens/home.dart';
import 'package:date_dif/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ValidatorPage extends StatelessWidget {
  const ValidatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomePage();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something Went Wrong!'));
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
