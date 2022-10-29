import 'package:fdoc/models/error_model.dart';
import 'package:fdoc/repositories/auth.dart';
import 'package:fdoc/repositories/local_storage.dart';
import 'package:fdoc/router.dart';
import 'package:fdoc/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

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

  String? token = '';

  void getUserData() async {
    ErrorModel errorModel = await ref.read(authProvider).getUserData();
    if (errorModel.data == null) token == '';
    print('init');
    errorModel.data != null
        ? ref.read(userProvider.notifier).update((state) => errorModel.data)
        : '';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp.router(
      title: "fdoc",
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          var user = ref.watch(userProvider);
          if (user != null) {
            if (user.token != null) {
              if (user.token!.isNotEmpty) {
                return loggedInRoute;
              }
            }
          }
          return loggedOutRoute;
          // return user != null || user!.token!.isNotEmpty
          //     ? loggedInRoute
          //     : loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
      // home: LoginScreen(),
    );
  }
}
