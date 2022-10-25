import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:fdoc/models/error_model.dart';
import 'package:fdoc/repositories/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:fdoc/constants.dart';
import 'package:fdoc/models/user_model.dart';

final authProvider = Provider((ref) => GoogleAuth(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStorage: LocalStorage()));

final userProvider = StateProvider<UserModel?>((ref) => null);

class GoogleAuth {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorage _localStorage;
  GoogleAuth(
      {required GoogleSignIn googleSignIn,
      required LocalStorage localStorage,
      required Client client})
      : _googleSignIn = googleSignIn,
        _localStorage = localStorage,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel errorModel = ErrorModel("Unexpected error occur", null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc =
            UserModel(user.displayName, user.email, user.photoUrl, '', '');

        var res = await _client.post(Uri.parse("${kBaseUrl}api/v1/fdoc/signup"),
            body: userAcc.toJson(),
            headers: {'Content-Type': 'Application/json; charset=UTF-8'});
        switch (res.statusCode) {
          case 201:
            final newUser = userAcc.copyWith(
                uid: jsonDecode(res.body)['user']['_id'],
                token: jsonDecode(res.body)['token']);
            _localStorage.setToken(newUser.token);
            errorModel = ErrorModel(null, newUser);
            break;
          case 200:
            final newUser = userAcc.copyWith(
                uid: jsonDecode(res.body)['user']['_id'],
                token: jsonDecode(res.body)['token']);
            _localStorage.setToken(newUser.token);
            errorModel = ErrorModel(null, newUser);
            break;
          default:
            errorModel = ErrorModel(
                'Unexpected Error => status:${res.statusCode.toString()} , body:${res.body.toString()}',
                null);

            print(res.statusCode.toString() + res.body.toString());
            break;
        }
        // print(user.email);
        // print(user.displayName);
        // print(user.photoUrl);
      }
    } catch (e) {
      errorModel = ErrorModel(e.toString(), null);

      print(e);
    }
    return errorModel;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel errorModel = ErrorModel("Unexpected error occur", null);
    try {
      var token = await _localStorage.getToken();
      if (token != null) {
        var res = await _client.get(Uri.parse("${kBaseUrl}api/v1/fdoc"),
            headers: {
              'Content-Type': 'Application/json; charset=UTF-8',
              'x-auth-token': token
            });
        switch (res.statusCode) {
          case 201:
            final newUser =
                UserModel.fromJson(jsonEncode(jsonDecode(res.body)['user']))
                    .copyWith(token: token);
            _localStorage.setToken(newUser.token);
            errorModel = ErrorModel(null, newUser);
            break;
          case 200:
            final newUser =
                UserModel.fromJson(jsonEncode(jsonDecode(res.body)['user']))
                    .copyWith(token: token);
            _localStorage.setToken(newUser.token);
            errorModel = ErrorModel(null, newUser);
            break;
          default:
            errorModel = ErrorModel(
                'Unexpected Error => status:${res.statusCode.toString()} , body:${res.body.toString()}',
                null);

            print(res.statusCode.toString() + res.body.toString());

            break;
        }
        // print(user.email);
        // print(user.displayName);
        // print(user.photoUrl);
      }
    } catch (e) {
      errorModel = ErrorModel(e.toString(), null);

      print(e);
    }
    return errorModel;
  }
}
