import 'package:api/features/auth/domain/repositories/auth_repository.dart';
import 'package:api/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial());

  Future<void> signInWithGoogle() async {
    emit(const AuthState.loading());
    try {
      final userCredential = await _authRepository.signInWithGoogle();
      emit(AuthState.success(userCredential));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(const AuthState.loading());
    try {
      final userCredential = await _authRepository.signInWithFacebook();
      emit(AuthState.success(userCredential));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(const AuthState.loading());
    try {
      final userCredential =
          await _authRepository.signInWithEmailAndPassword(email, password);
      emit(AuthState.success(userCredential));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }
} 