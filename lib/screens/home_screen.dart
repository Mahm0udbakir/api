import 'package:api/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_cubit.dart';
import '../di/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserCubit>()..fetchUserById('7947399'),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OneUserLoaded) {
              final users = state.user;
              return Container(
                height: 50,
                color: Colors.amber,
                child: Center(child: Text(users.name ?? '')),
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
