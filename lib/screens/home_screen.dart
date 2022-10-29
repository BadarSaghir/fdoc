import 'package:fdoc/repositories/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void logout(BuildContext context, WidgetRef ref) {
    ref.read(authProvider).signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () => {logout(context, ref)},
          icon: const Icon(Icons.logout),
        )
      ]),
      body: Center(child: Text(ref.watch(userProvider)!.email ?? "hello")),
    );
  }
}
