import 'package:fdoc/models/error_model.dart';
import 'package:fdoc/repositories/auth.dart';
import 'package:fdoc/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async {
    ErrorModel errorModel = await ref.read(authProvider).getUserData();
    if (errorModel != null && errorModel.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var user = ref.watch(userProvider);
    return MaterialApp(
      title: 'fdoc',
      home: user != null ? HomeScreen() : LoginScreen(),
    );
  }
}
