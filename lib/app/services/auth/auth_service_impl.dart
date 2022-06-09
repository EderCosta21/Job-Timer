// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<void> SignIn() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> SingOut() async {
    //fazer o logout
    await FirebaseAuth.instance.signOut();
    // desconectar do googleSingIn
    GoogleSignIn().disconnect();
  }
}
