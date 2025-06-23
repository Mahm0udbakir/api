import 'package:api/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:api/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      return await _remoteDataSource.signInWithGoogle();
    } catch (e) {
      // Here you can handle exceptions from the data source,
      // log them, or rethrow a more specific domain exception.
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    try {
      return await _remoteDataSource.signInWithFacebook();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _remoteDataSource.signInWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
    } catch (e) {
      rethrow;
    }
  }
} 