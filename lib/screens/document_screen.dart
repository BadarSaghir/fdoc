import 'package:fdoc/models/document_model.dart';
import 'package:fdoc/repositories/document_repo.dart';
import 'package:fdoc/repositories/socketRepo.dart';
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
  final quill.QuillController _controller = quill.QuillController.basic();
  ErrorModel? errorModel;
  SocketRepo socketRepo = SocketRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketRepo.joinRoom(widget.id);
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
    // ignore: todo
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
                backgroundColor: kBlueColor,
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
                width: MediaQuery.of(context).size.width * 0.2,
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {});
                    updateTitle(ref, value);
                  },
                  controller: titleController,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: kBlueColor),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 10),
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: kGreyColor, width: 0.1)),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          children: [
            quill.QuillToolbar.basic(
              controller: _controller,
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: quill.QuillEditor.basic(
                        controller: _controller, readOnly: false),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
