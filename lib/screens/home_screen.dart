import 'package:api/cubit/user_state.dart';
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
                  name: 'Mahmoud Beeko',
                  email: 'mahmoud_bakir@example.com',
                  gender: 'male',
                  status: 'active',
                ),
                'Bearer e1a059a025515f7086ef5d20cfc4a1b2c594c8e995564fb883d2297285526bf3',
              ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserCreated) {
              final user = state.newUser;
              return Container(
                height: 50,
                color: Colors.amber,
                child: Center(child: Text(user.name ?? '')),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No users found.'));
          },
        ),
      ),
    );
  }
}
