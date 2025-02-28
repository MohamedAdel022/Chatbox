import 'package:chat/core/routing/app_router.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:flutter/material.dart';

class ChatBoxAPP extends StatelessWidget {
  const ChatBoxAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: Routes.onBoardingScreen,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}