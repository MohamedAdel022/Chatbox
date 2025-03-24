import 'package:chat/core/routing/app_router.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBoxAPP extends StatelessWidget {
  const ChatBoxAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppTheme.primaryColor),
              useMaterial3: true,
            ),
            initialRoute: Routes.chatScreen,
            onGenerateRoute: AppRouter.generateRoute,
          );
        });
  }
}
