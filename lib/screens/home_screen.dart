import 'package:api/cubit/result_state.dart';
import 'package:api/models/user_model.dart';
import 'package:api/utils/api_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_cubit.dart';
import '../di/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              getIt<UserCubit>()..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: BlocBuilder<UserCubit, ResultState<User>>(
          builder: (context, state) {
            return state.when(
              idle: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (userData) => Container(
                height: 50,
                color: Colors.red,
                child: Center(child: Text(userData.email.toString())),
              ),
              error: (networkException) => Center(
                child: Text(NetworkExceptions.getErrorMessage(networkException)),
              ),
            );
          },
        ),
      ),
    );
  }
}
