import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/onBoarding',
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: '/signIn',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignInView(),
        ),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignUpView(),
        ),
      ),
      GoRoute(
        path: '/forgetPassword',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const ForgotPasswordView(),
        ),
      ),
      GoRoute(
        path: '/homeBottomNavBar',
        builder: (context, state) => HomeBottomNavBar(),
      ),
    ],
    // Optional: Error page for undefined routes
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route found for ${state.uri}'),
      ),
    ),
  );
}
