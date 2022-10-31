import 'package:fdoc/models/error_model.dart';
import 'package:fdoc/repositories/auth.dart';
import 'package:fdoc/repositories/document_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../common/widgets/loader.dart';
import '../models/document_model.dart';

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});
//   void logout(BuildContext context, WidgetRef ref) {
//     var navigator = Routemaster.of(context);
//     ref.read(authProvider).signOut();
//     ref.read(userProvider.notifier).update((state) => null);
//     navigator.replace('/');
//   }

//   void createDocument(BuildContext context, WidgetRef ref) async {
//     var token = ref.read(userProvider)!.token;
//     var navigator = Routemaster.of(context);
//     final snackbar = ScaffoldMessenger.of(context);
//     final errorModel =
//         await ref.read(documentRepoProvider).createDocument(token ?? '');
//     if (errorModel.error == null) {
//       navigator.push("/document/${errorModel.data.id}");
//     } else {
//       snackbar.showSnackBar(
//         SnackBar(
//           content: Text(errorModel.error!),
//         ),
//       );
//     }
//   }

//   removeById(String id, BuildContext context, WidgetRef ref) {
//     ref.read(documentRepoProvider).removeDocumentById(id);
//   }

//   void navigateToDocument(BuildContext context, String documentId) {
//     Routemaster.of(context).push('/document/$documentId');
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(actions: [
//         IconButton(
//           onPressed: () => {createDocument(context, ref)},
//           icon: const Icon(Icons.add),
//         ),
//         IconButton(
//           onPressed: () => logout(context, ref),
//           icon: const Icon(Icons.logout),
//         )
//       ]),
//       body: FutureBuilder(
//         future: ref.watch(documentRepoProvider).getDocuments(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Loader();
//           }

//           return Center(
//             child: Container(
//               width: 600,
//               margin: const EdgeInsets.only(top: 10),
//               child: ListView.builder(
//                 itemCount: snapshot.data!.data!.length,
//                 itemBuilder: (context, index) {
//                   DocumentModel document = snapshot.data!.data[index];

//                   return InkWell(
//                     onTap: () => navigateToDocument(context, document.id),
//                     child: Card(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 50,
//                             child: Card(
//                               child: Center(
//                                 child: Text(
//                                   document.title,
//                                   style: const TextStyle(
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () =>
//                                 {removeById(document.id, context, ref)},
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<ErrorModel>? futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // futureData = ref.read(documentRepoProvider).getDocuments();
  }

  void getData() {
    futureData = ref.read(documentRepoProvider).getDocuments();
  }

  void logout(BuildContext context, WidgetRef ref) {
    var navigator = Routemaster.of(context);
    ref.read(authProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
    navigator.replace('/');
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    var token = ref.read(userProvider)!.token;
    var navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);
    final errorModel =
        await ref.read(documentRepoProvider).createDocument(token ?? '');
    if (errorModel.error == null) {
      navigator.push("/document/${errorModel.data.id}");
    } else {
      snackbar.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  removeById(String id, BuildContext context, WidgetRef ref) {
    ref.read(documentRepoProvider).removeDocumentById(id);
  }

  void navigateToDocument(BuildContext context, String documentId) {
    Routemaster.of(context).push('/document/$documentId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () => {createDocument(context, ref)},
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () => logout(context, ref),
          icon: const Icon(Icons.logout),
        )
      ]),
      body: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          return Center(
            child: Container(
              width: 600,
              margin: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  DocumentModel document = snapshot.data!.data[index];

                  return InkWell(
                    onTap: () => navigateToDocument(context, document.id),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Card(
                              child: Center(
                                child: Text(
                                  document.title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {});
                              removeById(document.id, context, ref);
                              getData();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
