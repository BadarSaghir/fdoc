import 'package:fdoc/repositories/document_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/error_model.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  void getUserData() async {
    ErrorModel errorModel = await ref.read(documentRepoProvider).getDocuments();

    errorModel.data != null
        ? ref.read(documentProvider.notifier).update((state) => errorModel.data)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(widget.id),
      ),
    );
  }
}
