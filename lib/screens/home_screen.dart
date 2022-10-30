import 'package:fdoc/repositories/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void logout(BuildContext context, WidgetRef ref) {
    var navigator = Routemaster.of(context);
    ref.read(authProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
    navigator.replace('/');
  }

  void navigateToDocument(BuildContext context, String documentId) {
    Routemaster.of(context).push('/document/$documentId');
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
          onPressed: () => logout(context, ref),
          icon: const Icon(Icons.logout),
        )
      ]),
      body: Center(child: Text(ref.watch(userProvider)!.email ?? "hello")),
    );
  }
}
