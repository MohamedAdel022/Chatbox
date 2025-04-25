import 'package:chat/core/di/get_it.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:chat/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:chat/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat/features/chat/presentation/views/chat_screen.dart';
import 'package:chat/features/chat/presentation/views/group_chat_screen.dart';
import 'package:chat/features/messages/domain/repositories/message_repository.dart';
import 'package:chat/features/messages/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat/features/navigation/presentation/view/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/signup_screen.dart';
import '../../features/messages/presentation/views/messages_screen.dart';
import '../../features/onboarding/presentation/views/onboarding_screen.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.bottomNavLayout:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ChatCubit(
                      messageRepository: getIt<ChatRepository>()),
                  child: const MessagesScreen(),
                ));
      case Routes.chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case Routes.groupChatScreen:
        return MaterialPageRoute(builder: (_) => const GroupChatScreen());
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
