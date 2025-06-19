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
      create: (_) => getIt<UserCubit>()..deleteUser('7958139', 'Bearer e1a059a025515f7086ef5d20cfc4a1b2c594c8e995564fb883d2297285526bf3'),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: BlocBuilder<UserCubit, ResultState<List<User>>>(
          builder: (context, ResultState<List<User>> state) {
            return state.when(
              idle: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              success:
                  (List<User> users) => Container(
                    height: 200,
                    color: Colors.red,
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder:
                          (context, index) => Text(users[index].name!),
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
