import 'package:api/cubit/user_state.dart';
import 'package:api/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit(this.userRepository) : super(UserInitial());

  Future<void> fetchUsers() async {
    emit(UserLoading());
    try {
      final users = await userRepository.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> fetchUserById(String id) async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUserById(id);
      emit(OneUserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> createUser(User newUser, String token) async {
    emit(UserLoading());
    try {
      final user = await userRepository.createUser(newUser, token);
      emit(UserCreated(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
