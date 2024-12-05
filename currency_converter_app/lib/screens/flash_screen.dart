import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:page_transition/page_transition.dart';
import '../config/color_codes.dart';
import 'dashboard_screen.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(
        width: 60.w,
        child: Image.asset('assets/images/code94-logo-white.png'),
      ),
      backgroundColor: ColorCodes().color1,
      nextScreen: const DashboardScreen(),
      splashIconSize: 350.dp,
      duration: 1800,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
