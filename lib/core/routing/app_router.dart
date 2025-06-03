import 'package:chat/core/di/get_it.dart';
import 'package:chat/core/routing/guards/auth_guard.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:chat/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat/features/chats/presentation/manager/unread_count_cubit/unread_count_cubit.dart';
import 'package:chat/features/messages/domin/repos/message_repo.dart';
import 'package:chat/features/messages/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat/features/messages/presentation/views/messages_screen.dart';
import 'package:chat/features/chats/domain/repositories/chat_repository.dart'
    as repo;
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat/features/navigation/presentation/view/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/signup_screen.dart';
import '../../features/onboarding/presentation/views/onboarding_screen.dart';
import 'guards/route_guard.dart';
import 'routes.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final FirebaseAuth _firebaseAuth = getIt<FirebaseAuth>();

  // Create an instance of the AuthGuard
  static final AuthGuard _authGuard = AuthGuard(firebaseAuth: _firebaseAuth);

  // Check guards for a specific route
  static bool _checkGuards(
      List<RouteGuard> guards, BuildContext? context, dynamic arguments) {
    for (final guard in guards) {
      if (!guard.guardCheck(
          context ?? navigatorKey.currentContext!, arguments)) {
        // If any guard fails, navigate to the redirect route
        navigatorKey.currentState?.pushReplacementNamed(guard.redirectTo);
        return false;
      }
    }
    return true;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.bottomNavLayout:
        // Check if user is authenticated before allowing access to bottom nav layout
        if (!_checkGuards(
            [_authGuard], navigatorKey.currentContext, settings.arguments)) {
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ChatCubit>(
                create: (context) => ChatCubit(
                  messageRepository: getIt<repo.ChatRepository>(),
                  firebaseAuth: _firebaseAuth,
                ),
              ),
              BlocProvider<UnreadCountCubit>(
                create: (context) => UnreadCountCubit(
                  chatRepository: getIt<repo.ChatRepository>(),
                  firebaseAuth: _firebaseAuth,
                ),
              ),
            ],
            child: const BottomNavLayout(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SigninCubit(getIt<AuthRepo>()),
                  child: const LoginScreen(),
                ));
      case Routes.signupScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignupCubit(getIt<AuthRepo>()),
                  child: const SignupScreen(),
                ));
      case Routes.messagesScreen:
        // Check if user is authenticated before allowing access to messages screen
        if (!_checkGuards(
            [_authGuard], navigatorKey.currentContext, settings.arguments)) {
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        }

        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null || args['user'] == null) {
          // Handle case where arguments are missing
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('User information is missing')),
            ),
          );
        }
        final user = args['user'] as UserEntity;
        final chatId = args['chatId'] as String?;

        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<MessageCubit>(
                      create: (context) =>
                          MessageCubit(messageRepo: getIt<MessageRepo>()),
                    ),
                    BlocProvider<UnreadCountCubit>(
                      create: (context) => UnreadCountCubit(
                        chatRepository: getIt<repo.ChatRepository>(),
                        firebaseAuth: _firebaseAuth,
                      ),
                    ),
                  ],
                  child: MessagesScreen(user: user, chatId: chatId!),
                ));
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

  // Navigation helper methods
  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushReplacement(String routeName,
      {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushAndRemoveUntil(String routeName,
      {dynamic arguments, bool Function(Route<dynamic>)? predicate}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (_) => false,
      arguments: arguments,
    );
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }
}
