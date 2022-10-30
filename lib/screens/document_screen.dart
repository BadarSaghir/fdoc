import 'package:fdoc/models/document_model.dart';
import 'package:fdoc/repositories/auth.dart';
import 'package:fdoc/repositories/document_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../colors.dart';
import '../models/error_model.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');
  quill.QuillController _controller = quill.QuillController.basic();
  ErrorModel? errorModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDocumentData();
  }

  void fetchDocumentData() async {
    errorModel =
        await ref.read(documentRepoProvider).getDocumentById(widget.id);
    if (errorModel!.data != null) {
      titleController.text = (errorModel!.data as DocumentModel).title;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
  }

  void updateTitle(WidgetRef ref, String title) async {
    ref.read(documentRepoProvider).updateTitleById(id: widget.id, title: title);
    fetchDocumentData();
  }

  void getUserData() async {
    ErrorModel errorModel =
        await ref.read(documentRepoProvider).getDocumentById(widget.id);

    errorModel.data != null
        ? ref.read(documentProvider.notifier).update((state) => errorModel.data)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.lock,
                  size: 16,
                ),
                label: Text("Share"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBluekColor,
                ),
              ),
            ),
          ],
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.bookmark_add_rounded,
                  color: Colors.blue,
                  size: 36,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 180,
                  child: TextField(
                    onSubmitted: (value) {
                      setState(() {});
                      updateTitle(ref, value);
                    },
                    controller: titleController,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBluekColor),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: kGreyColor, width: 0.1)),
            ),
            preferredSize: const Size.fromHeight(1),
          ),
        ),
        body: Column(
          children: [
            quill.QuillToolbar.basic(
              controller: _controller,
            ),
            Expanded(
              child: SizedBox(
                width: 750,
                child: Card(
                  child: quill.QuillEditor.basic(
                      controller: _controller, readOnly: false),
                ),
              ),
            )
          ],
        ));
  }
}
