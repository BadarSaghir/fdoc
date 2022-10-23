import 'package:fdoc/screens/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/search.png',
              height: 20,
            ),
            label: const Text(
              "Sign in with Google",
              style: TextStyle(color: kBlackColor),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50), backgroundColor: kWhiteColor)),
      ),
    );
  }
}
