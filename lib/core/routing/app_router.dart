import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/signup_screen.dart';
import '../../features/home/presentation/views/home_screen.dart';
import '../../features/onboarding/presentation/views/onboarding_screen.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
