import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithFacebook();
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
} 