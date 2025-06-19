import 'package:api/cubit/result_state.dart';
import 'package:api/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';

class UserCubit extends Cubit<ResultState<List<User>>> {
  final UserRepository userRepository;
  UserCubit(this.userRepository) : super(Idle());

  Future<void> getUsers() async {
    emit(const Loading());
    final result = await userRepository.getUsers();
    result.when(
      success: (users) => emit(ResultState.success(users)),
      failure: (error) => emit(ResultState.error(error)),
    );
  }

  Future<void> getUserById(String id) async {
    emit(const Loading());
    final result = await userRepository.getUserById(id);
    result.when(
      success: (user) => emit(ResultState.success([user])),
      failure: (error) => emit(ResultState.error(error)),
    );
  }

  Future<void> createUser(User newUser, String token) async {
    emit(const Loading());
    final result = await userRepository.createUser(newUser, token);
    result.when(
      success: (user) => emit(ResultState.success([user])),
      failure: (error) => emit(ResultState.error(error)),
    );
  }

  Future<void> deleteUser(String id, String token) async {
    emit(const Loading());
    final result = await userRepository.deleteUser(id, token);
    result.when(
      success: (user) => emit(ResultState.success([user])),
      failure: (error) => emit(ResultState.error(error)),
    );
  }
}
