import 'package:api/core/di/service_locator.dart';
import 'package:api/core/functions/custom_snackbar.dart';
import 'package:api/core/utils/colors.dart';
import 'package:api/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:api/features/auth/presentation/cubit/auth_state.dart';
import 'package:api/features/user/presentation/cubit/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (userCredential) {
              successSnackBar(
                context,
                InfoSnackBarState(
                    'Successfully signed in as ${userCredential.user?.displayName ?? userCredential.user?.email ?? 'user'}'),
              );
              // TODO: Navigate to the home screen or another part of your app
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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Spacer(flex: 2),
                      Text(
                        "Let's get started\nsaving food!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: MyAppColors.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/bag.jpg',
                        height: 250,
                      ),
                      const Spacer(flex: 2),
                      _SocialSignInButton(
                        text: 'Continue with Google',
                        icon: Image.asset('assets/images/google.jpeg',
                            height: 24, width: 24),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithGoogle(),
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: MyAppColors.primaryColor,
                      ),
                      const SizedBox(height: 12),
                      _SocialSignInButton(
                        text: 'Continue with Facebook',
                        icon: const FaIcon(FontAwesomeIcons.facebook,
                            color: Colors.white),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithFacebook(),
                        backgroundColor: const Color(0xFF1877F2),
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      _SocialSignInButton(
                        text: 'Continue with Email',
                        icon: const Icon(Icons.email_outlined, color: Colors.white),
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

class _SocialSignInButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const _SocialSignInButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(text,
          style: GoogleFonts.poppins(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w500)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 1.5)
              : BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      ),
    );
  }
}
