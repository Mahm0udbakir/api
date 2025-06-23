import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _moveController;
  late AnimationController _bounceController;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // 1. Move from top-center to center
    _moveAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.0, -1.0), // top-center
          end: const Offset(0.0, 0.0),    // center
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50, // 1 second (50% of 2 seconds)
      ),
      // 2. Pause at center (weight 0, stays at center)
      TweenSequenceItem(
        tween: ConstantTween<Offset>(const Offset(0.0, 0.0)),
        weight: 10,
      ),
      // 3. Move from center to right-center
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(1.0, 0.0), // right-center
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_moveController);

    // 4. Bounce (scale)
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 0.9).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_bounceController);

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    // Move to center
    await _moveController.animateTo(0.5);
    // Pause for 1s
    await Future.delayed(const Duration(seconds: 1));
    // Bounce
    await _bounceController.forward();
    // Continue move to right-center
    await _moveController.animateTo(1.0);
    // Navigate to sign-in
    context.go('/signIn');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_moveController, _bounceController]),
            builder: (context, child) {
              return FractionalTranslation(
                translation: _moveAnimation.value,
                child: ScaleTransition(
                  scale: _moveController.value >= 0.5 && _moveController.value < 0.6
                      ? _scaleAnimation
                      : AlwaysStoppedAnimation(1.0),
                  child: child,
                ),
              );
            },
            child: Center(
              child: Image.asset('assets/images/logo.png', height: 200),
            ),
          ),
        ],
      ),
    );
  }
}
