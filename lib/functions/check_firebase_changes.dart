import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

void checkFirebaseAuthStateChanges() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
    } else {
      if (kDebugMode) {
        if (user.emailVerified) {
          print('User is signed in and email is verified!');
        } else {
          print('User is signed in but email is not verified!');
        }
      }
    }
  });
}
