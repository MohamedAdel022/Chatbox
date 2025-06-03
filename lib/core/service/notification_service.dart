import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat/core/routing/app_router.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationUtils {
  NotificationUtils._();

  factory NotificationUtils() => _instance;
  static final NotificationUtils _instance = NotificationUtils._();
  static final AwesomeNotifications awesomeNotifications =
      AwesomeNotifications();

  /// while creating channel do not mistake for creating channel key or not confusing with channel key create same channel key and use for notification
  /// one more thing prevent with null value or like null string because it will be giving error like native java null pointer exception so be care full
  /// while passing a data or creating a notification..
  void listen() {
    FirebaseMessaging.onMessage.listen((m) async {
      await listenToNotification(m);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage m) async {
      await awesomeNotifications.createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'basic_channel',
          title: m.notification?.title ?? 'New Message',
          body: m.notification?.body ?? '',
          payload: m.data.cast(),
          notificationLayout: NotificationLayout.Default,
        ),
      );
    });
  }

  static Future<void> listenToNotification(RemoteMessage m) async {
    await awesomeNotifications.createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'basic_channel',
            title: m.notification?.title,
            body: m.notification?.body,
            payload: m.data.cast()),
        actionButtons: []);
    return;
  }

  ///here where the service will configure the notification service
  /// you can intialize firebase app and get fcmToken to store it
  /// then start listen with awesome notification
  Future<void> configuration() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final fcm = await FirebaseMessaging.instance.getToken();
      log('FCM token $fcm');

      await awesomeNotifications.initialize(
          null,
          [
            NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic Notifications',
              defaultColor: AppTheme.primaryColor,
              importance: NotificationImportance.High,
              channelShowBadge: true,
              onlyAlertOnce: true,
              channelDescription: 'Basic Instant Notification',
            ),
          ],
          debug: true);
      listen();
    } catch (e) {
      log(e.toString());
    }
  }

  /// check if notification permission allowed or not
  /// and request permission
  Future<void> checkingPermissionNotification() async {
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  ///this method is for checking the awesomenotification and can be used to create immediate notifications
  Future<void> createLocalInstantNotification() async {
    await awesomeNotifications.createNotification(
      content: NotificationContent(
          id: -1,
          channelKey: 'android',
          title: 'Buy Favorite Product',
          body: "Hurry Up To Grab This Product Loot With Just 80% Off",
          bigPicture:
              'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
          largeIcon: 'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
          notificationLayout: NotificationLayout.BigPicture,
          payload: {'notificationId': '1234567890'}),
    );
  }

  ///if you want to create notification from json data immediatly
  Future<void> jsonDataNotification(Map<String, Object> jsonData) async {
    await awesomeNotifications.createNotificationFromJsonData(jsonData);
  }

  ///now this method is for schedule notification in the duration you send as param
  Future<void> createScheduleNotification(
      DateTime date, Map<String, dynamic> notification) async {
    try {
      await awesomeNotifications.createNotification(
        schedule: NotificationCalendar(
          day: date.day,
          month: date.month,
          year: date.year,
          hour: date.hour,
          minute: date.minute,
        ),
        content: NotificationContent(
          id: -1,
          channelKey: 'android',
          title: notification['title'],
          body: notification['body'],
          //edit this fields due to your preferences
          bigPicture: notification['image'],
          notificationLayout: NotificationLayout.BigPicture,
        ),
      );
    } catch (e) {}
  }

  /// this method is triggered when user press on notification
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log('Notification action received: ${receivedAction.payload}');

    if (receivedAction.payload == null) {
      log('Error: Notification payload is null');
      return;
    }

    final chatId = receivedAction.payload?['chatId'];
    final userJson = receivedAction.payload?['user'];

    if (chatId == null || userJson == null) {
      log('Error: Missing required data in notification payload');
      return;
    }

    final UserEntity user = UserModel.fromJson(jsonDecode(userJson));

    // Navigate with properly formatted arguments
    AppRouter.navigatorKey.currentState?.pushNamed(
      Routes.messagesScreen,
      arguments: {
        'user': user,
        'chatId': chatId,
      },
    );
  }

  /// this method to start the listeing or start the whole service at all
  Future<void> startListeningNotificationEvents() async {
    log("check data with start listening");
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  }

  ///this methods when notification created or displayed o dismissed
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    log("onNotificationCreatedMethod");

    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    log("onNotificationDisplayedMethod");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log("onDismissActionReceivedMethod");
  }
}
