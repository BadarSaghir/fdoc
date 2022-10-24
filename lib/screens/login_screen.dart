import 'package:fdoc/auth/auth.dart';
import 'package:fdoc/colors.dart';
import 'package:fdoc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    var sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel = await ref.read(authProvider).signInWithGoogle();
    if (errorModel.error != null) {
      sMessenger.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    } else {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => signInWithGoogle(ref, context),
          icon: Image.asset(
            'assets/images/search.png',
            height: 20,
          ),
          label: const Text(
            "Sign in with Google",
            style: TextStyle(color: kBlackColor),
          ),
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 50), backgroundColor: kWhiteColor),
        ),
      ),
    );
  }
}
