import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required FacebookAuth facebookAuth,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;

  @override
  Future<UserCredential> signInWithGoogle() async {
    //! TODO: Ensure you have configured Google Sign-In correctly in your Firebase project and on both Android and iOS.
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google Sign-In was cancelled by the user.');
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    // TODO: Ensure you have configured Facebook Login correctly in your Firebase project and on both Android and iOS.
    final LoginResult result = await _facebookAuth.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);
      return await _firebaseAuth.signInWithCredential(credential);
    } else if (result.status == LoginStatus.cancelled) {
      throw Exception('Facebook Sign-In was cancelled by the user.');
    } else {
      throw Exception(result.message ?? 'An unknown Facebook error occurred.');
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    // For a real app, you would also need a sign-up flow.
    // This implementation assumes the user already exists.
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // You can handle specific error codes here (e.g., 'user-not-found', 'wrong-password').
      throw Exception(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    await _firebaseAuth.signOut();
  }
} 