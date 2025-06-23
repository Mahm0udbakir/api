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

class _SignInScreenView extends StatefulWidget {
  const _SignInScreenView();

  @override
  State<_SignInScreenView> createState() => _SignInScreenViewState();
}

class _SignInScreenViewState extends State<_SignInScreenView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Left-center
      end: const Offset(0.0, 0.0), // Center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (userCredential) async {
              getIt<CacheHelper>().saveData(
                key: ApiStrings.userIdKey,
                value: userCredential.user!.uid,
              );
              successSnackBar(
                context,
                InfoSnackBarState(
                    'Successfully signed in as ${userCredential.user?.displayName ?? userCredential.user?.email ?? 'user'}'),
              );
              await _showCookieConsentDialog(context);
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
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 40.h),
                      Text(
                        "Let's get started\nsaving food!",
                        textAlign: TextAlign.center,
                        style: MyAppTextStyles.montserrat700size24,
                      ),
                      SizedBox(height: 20.h),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return FractionalTranslation(
                            translation: _logoAnimation.value,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 250.h,
                        ),
                      ),
                      SizedBox(height: 120.h),
                      SocialSignInButton(
                        text: 'Continue with Google',
                        icon: Image.asset('assets/images/google.png',
                            height: 24.r, width: 24.r),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithGoogle(),
                        backgroundColor: Colors.white,
                        textColor: MyAppColors.secondaryColor,
                        borderColor: MyAppColors.secondaryColor,
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
                      SizedBox(height: 40.h),
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

  Future<void> _showCookieConsentDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CookieConsentDialog(),
    );
  }
}

class CookieConsentDialog extends StatelessWidget {
  const CookieConsentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Icon(Icons.spa, size: 48, color: Colors.teal), // Placeholder for logo
            ),
            const SizedBox(height: 16),
            Text(
              'We use cookies and similar technologies to enhance your app experience, analyse app usage and traffic, and personalise content and advertisements. Below we explain what types of personal data we collect and how we use, share, and retain it.',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 24),
            Text(
              'Mandatory cookies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Technically necessary and statistics data',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const Spacer(),
                Switch(value: true, onChanged: null),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '''We collect technically necessary data to make our app function properly. This data is essential to enable you to browse the app and use its features. We also collect statistical data that allows us to analyse and understand app traffic, user behaviour, and usage patterns at the aggregate level. The statistical data obtained from the app is aggregated and used to improve our app's performance and user experience.''',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: const Text('Read more'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Allow all'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      side: const BorderSide(color: Colors.teal),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Allow selection'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

