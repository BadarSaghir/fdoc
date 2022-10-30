// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fdoc/models/error_model.dart';
import 'package:fdoc/repositories/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../models/document_model.dart';

final documentRepoProvider = Provider((ref) => DocumentRepo(client: Client()));
final documentProvider = StateProvider<DocumentModel?>((ref) => null);

class DocumentRepo {
  final Client _client;
  final LocalStorage _localStorage = LocalStorage();
  DocumentRepo({
    required Client client,
  }) : _client = client;

  Future<ErrorModel> getDocuments() async {
    ErrorModel errorModel = ErrorModel("Unexpected error occur", null);
    try {
      var token = await _localStorage.getToken();
      if (token == null || token == '') {
        debugPrint('Unexpected error occur -----No Token');
        return ErrorModel("Unexpected error occur -----No Token", null);
      }
      if (token != null) {
        var res = await _client
            .get(Uri.parse("${kBaseUrl}api/v1/fdoc/documents"), headers: {
          'Content-Type': 'Application/json; charset=UTF-8',
          'x-auth-token': token
        });
        switch (res.statusCode) {
          case 201:
            final documents = DocumentModel.fromJson(res.body);
            errorModel = ErrorModel(null, documents);
            break;
          case 200:
            final documents = DocumentModel.fromJson(res.body);
            errorModel = ErrorModel(null, documents);
            break;
          default:
            errorModel = ErrorModel(
                'Unexpected Error => status:${res.statusCode.toString()} , body:${res.body.toString()}',
                null);
            debugPrint(res.statusCode.toString() + res.body.toString());
            break;
        }
      }
    } catch (e) {
      errorModel = ErrorModel(e.toString(), null);
      debugPrint(e.toString());
    }
    return errorModel;
  }

  Future<ErrorModel> createDocument() async {
    ErrorModel errorModel = ErrorModel("Unexpected error occur", null);
    try {
      var token = await _localStorage.getToken();
      if (token == null || token == '') {
        debugPrint('Unexpected error occur -----No Token');
        return ErrorModel("Unexpected error occur -----No Token", null);
      }
      if (token != null) {
        var res = await _client.post(
          Uri.parse("${kBaseUrl}api/v1/fdoc/document"),
          headers: {
            'Content-Type': 'Application/json; charset=UTF-8',
            'x-auth-token': token
          },
          body:
              jsonEncode({'createdAt': DateTime.now().millisecondsSinceEpoch}),
        );
        switch (res.statusCode) {
          case 201:
            final documents = DocumentModel.fromJson(
              jsonEncode(jsonDecode(res.body)['document']),
            );
            errorModel = ErrorModel(null, documents);
            break;
          case 200:
            final documents = DocumentModel.fromJson(
              jsonEncode(jsonDecode(res.body)['document']),
            );

            errorModel = ErrorModel(null, documents);
            break;
          default:
            errorModel = ErrorModel(
                'Unexpected Error => status:${res.statusCode.toString()} , body:${res.body.toString()}',
                null);
            debugPrint(res.statusCode.toString() + res.body.toString());
            break;
        }
      }
    } catch (e) {
      errorModel = ErrorModel(e.toString(), null);
      debugPrint(e.toString());
    }
    return errorModel;
  }
}
