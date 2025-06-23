import 'package:api/core/cache/cache_helper.dart';
import 'package:api/core/di/service_locator.dart';
import 'package:api/core/functions/custom_snackbar.dart';
import 'package:api/core/utils/api_strings.dart';
import 'package:api/core/utils/colors.dart';
import 'package:api/core/utils/text_styles.dart';
import 'package:api/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:api/features/auth/presentation/cubit/auth_state.dart';
import 'package:api/features/auth/presentation/widgets/social_sign_in_button.dart';
import 'package:api/features/home/presentation/cubit/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: const _SignInScreenView(),
    );
  }
}

class _SignInScreenView extends StatelessWidget {
  const _SignInScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (userCredential) {
              getIt<CacheHelper>().saveData(
                key: ApiStrings.userIdKey,
                value: userCredential.user!.uid,
              );
              successSnackBar(
                context,
                InfoSnackBarState(
                    'Successfully signed in as ${userCredential.user?.displayName ?? userCredential.user?.email ?? 'user'}'),
              );
              context.go('/home');
            },
            error: (message) {
              errorSnackBar(context, InfoSnackBarState(message));
            },
          );
        },
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Spacer(flex: 2),
                      Text(
                        "Let's get started\nsaving food!",
                        textAlign: TextAlign.center,
                        style: MyAppTextStyles.montserrat700size24,
                      ),
                      SizedBox(height: 20.h),
                      Image.asset(
                        'assets/images/bag.jpg',
                        height: 250.h,
                      ),
                      const Spacer(flex: 2),
                      SocialSignInButton(
                        text: 'Continue with Google',
                        icon: Image.asset('assets/images/google.png',
                            height: 24.r, width: 24.r),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithGoogle(),
                        backgroundColor: Colors.white,
                        textColor: MyAppColors.secondaryColor,
                        borderColor: MyAppColors.primaryColor,
                      ),
                      SizedBox(height: 18.h),
                      SocialSignInButton(
                        text: 'Continue with Facebook',
                        icon: FaIcon(FontAwesomeIcons.facebookF,
                            color: Colors.white, size: 24.r),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithFacebook(),
                        backgroundColor: const Color(0xFF1877F2),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 18.h),
                      SocialSignInButton(
                        text: 'Continue with Email',
                        icon: Icon(Icons.email_outlined,
                            color: Colors.white, size: 24.r),
                        onPressed: () => _showEmailSignInDialog(context),
                        backgroundColor: MyAppColors.primaryColor,
                        textColor: Colors.white,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              if (state is Loading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showEmailSignInDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Sign in with Email'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().signInWithEmailAndPassword(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Sign In'),
            ),
          ],
        );
      },
    );
  }
}

