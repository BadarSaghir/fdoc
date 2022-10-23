import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authProvider = Provider((ref) => GoogleAuth(googleSignIn: GoogleSignIn()));

class GoogleAuth{
  final GoogleSignIn _googleSignIn;
  GoogleAuth({required GoogleSignIn googleSignIn}): _googleSignIn=googleSignIn;
  void signInWithGoogle () async{
    try {
      final user= await _googleSignIn.signIn();
      if(user!=null){
        print(user.email);
        print(user.displayName);
        print(user.photoUrl);
      }
    } catch (e) {
      print(e);
    }
  }
}
