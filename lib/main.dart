import 'package:api/core/di/service_locator.dart';
import 'package:api/core/utils/colors.dart';
import 'package:api/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:api/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: MyAppColors.offWhite,
      ),
      home: const SignInScreen(),
    );
  }
}
