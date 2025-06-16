import 'package:api/cubit/result_state.dart';
import 'package:api/models/user_model.dart';
import 'package:api/utils/api_error_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';

class UserCubit extends Cubit<ResultState<User>> {
  final UserRepository userRepository;
  UserCubit(this.userRepository) : super(Idle());

  Future<void> fetchUsers() async {
    emit(Loading());
    final result = await userRepository.getUsers();
    result.when(
      success: (List<User> users) => emit(ResultState.success(user)),
      error: (NetworkExceptions e) => emit(Error(e)),
    );
  }

  // Future<void> fetchUserById(String id) async {
  //   emit(UserLoading());
  //   try {
  //     final user = await userRepository.getUserById(id);
  //     emit(OneUserLoaded(user));
  //   } catch (e) {
  //     emit(UserError(e.toString()));
  //   }
  // }

  Future<void> createUser(User newUser, String token) async {
    emit(Loading());
    final result = await userRepository.createUser(newUser, token);
    result.when(
      success: (User user) => emit(ResultState.success(user)),
      error: (NetworkExceptions e) => emit(Error(e)),
    );
  }

  // Future<void> deleteUser(String id, String token) async {
  //   emit(UserLoading());
  //   try {
  //     final user = await userRepository.deleteUser(id, token);
  //     emit(UserDeleted(user));
  //   } catch (e) {
  //     emit(UserError(e.toString()));
  //   }
  // }
}
