import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/data/firebase/firebase_options.dart';

import '../../modules/home/homepage/controllers/homepage_controller.dart';

class NotificationService extends GetxService {
  //* Variables
  static const channelId = 'notificationChannelId';
  static const channelName = 'notificationChannelName';
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings _initializationSettingsIOS =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: (
      id,
      title,
      body,
      payload,
    ) async {},
  );

  // Initializes the notification service
  Future<void> initNotification() async {
    try {
      await settingFirebase();

      await _messaging.requestPermission();

      final initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _initializationSettingsIOS,
      );
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } catch (e) {
      $log.e('Error initializing notifications: $e');
      rethrow;
    }
  }

  // Sends a notification
  Future<void> sendNotification(int id, String title, String body) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  // Cancels a notification
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancels all notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // Sets up Firebase
  Future<void> settingFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      await handleMessages();
    } catch (e) {
      $log.e('Error setting up Firebase: $e');
      rethrow;
    }
  }

  // Handles incoming messages
  Future<void> handleMessages() async {
    try {
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((message) async {
        final homeController = Get.find<HomepageController>();

        final notification = message.notification;
        if (notification != null) {
          await sendNotification(
            message.messageId.hashCode,
            notification.title ?? '',
            notification.body ?? '',
          );

          homeController.hasNotification.value = true;
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) async {
        final homeController = Get.find<HomepageController>();
        await homeController.onItemTapped(1);
      });
    } catch (e) {
      $log.e('Error handling messages: $e');
      rethrow;
    }
  }
}
