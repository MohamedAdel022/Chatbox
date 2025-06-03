import 'package:chat/chat_box.dart';
import 'package:chat/core/di/get_it.dart';
import 'package:chat/core/service/bloc_observer.dart';
import 'package:chat/core/service/notification_service.dart';
import 'package:chat/core/service/secure_storage_service.dart';
import 'package:chat/core/utils/network_checker.dart';
import 'package:chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  FlutterNativeSplash.remove();
  setupGitIt();
  Bloc.observer = AppBlocObserver();
  NetworkChecker.hasConnection();
  await SecureStorageService.init();

  // Initialize notification service
  final notificationUtils = NotificationUtils();
  await notificationUtils.configuration();
  await notificationUtils.checkingPermissionNotification();
  await notificationUtils.startListeningNotificationEvents();
  runApp(
    const ChatBoxAPP(),
  );
}
