import 'package:api/network/api_error_handler.dart';
import 'package:api/cubit/result_state.dart';
import 'package:api/models/user_model.dart';
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
              getIt<UserCubit>()..createUser(
                User(
                  name: 'John Doe',
                  email: 'john.doe30@example.com',
                  gender: 'male',
                  status: 'active',
                ),
                'Bearer e1a059a025515f7086ef5d20cfc4a1b2c594c8e995564fb883d2297285526bf3',
              ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: BlocBuilder<UserCubit, ResultState<User>>(
          builder: (context, ResultState<User> state) {
            return state.when(
              idle: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              success:
                  (User userData) => Container(
                    height: 50,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        userData.email.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              error:
                  (NetworkExceptions error) => Center(
                    child: Text(NetworkExceptions.getErrorMessage(error)),
                  ),
            );
          },
        ),
      ),
    );
  }
}
