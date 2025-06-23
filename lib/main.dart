import 'package:api/core/di/service_locator.dart';
import 'package:api/features/user/data/repositories/user_repository.dart';
import 'package:api/features/user/presentation/cubit/user_cubit.dart';
import 'package:api/features/user/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => UserCubit(getIt<UserRepository>()),
        child: const HomeScreen(),
      ),
    );
  }
}
