import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:premium_pay_seller/export_files.dart';




// Global plugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background handler (global)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize plugin in background isolate
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat_logo');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // BigPictureStyleInformation bigPictureStyleInformation =
  //     BigPictureStyleInformation(
  //   DrawableResourceAndroidBitmap('ic_large_logo'), // large icon
  //   largeIcon: DrawableResourceAndroidBitmap('ic_large_logo'),
  //   contentTitle: 'PremiumPay Notification',
  //   summaryText: 'Xabar matni',
  // );
  // Notification details
  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
      'high_importance_channel', 'High Importance Notifications',
      icon: 'ic_stat_logo',
      importance: Importance.high,
      priority: Priority.high,
      largeIcon:   DrawableResourceAndroidBitmap('ic_large_logo'),
      color: AppConstant.primaryColor
      // styleInformation: bigPictureStyleInformation
      
      );

  print("Background message received:");
  print("Message ID: ${message.messageId}");
  print("Notification title: ${message.notification?.title}");
  print("Notification body: ${message.notification?.body}");
  print("Data payload: ${message.data}");
  final id = message.data['id'] ?? "";
  final status = message.data["status"] ?? "";


  await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? "PremiumPay Notification",
      message.notification?.body ?? "Sizga yangi xabar keldi",
      NotificationDetails(android: androidDetails),
      payload: "$id-$status");
}

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}

// Initialize Firebase + notifications
Future<void> firebaseInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Create Android notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Initialize plugin for foreground notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat_logo');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );


  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
     
      final payload = response.payload;
      if (kDebugMode) {
        print("Payload : $payload");
      }
      if (payload.toString().split("-").length > 1) {
        final id = payload.toString().split("-")[0];
        final status = payload.toString().split("-")[1];
        {
          if ([
            "FINISHED",
            "CANCELED_BY_CLIENT",
            "CANCELED_BY_SCORING",
            "CANCELED_BY_DAILY"
          ].contains(status)) {
            rootNavigatorKey.currentContext
                ?.go('/application', extra: {"id": int.tryParse(id) ?? 0});
          } else {
            rootNavigatorKey.currentContext?.go('/singleApplication',
                extra: {"id": int.tryParse(id) ?? 0});
          }
        }
      }
    },
  );

  // Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (kDebugMode) {
      print("Foreground message received:");
      print("Message ID: ${message.messageId}");
      print("Notification title: ${message.notification?.title}");
      print("Notification body: ${message.notification?.body}");
      print("Data payload: ${message.data}");
    }
    final id = message.data['id'] ?? "";
    final status = message.data["status"] ?? "";
    
    await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title ?? "PremiumPay Notification",
        message.notification?.body ?? "Sizga yangi xabar keldi",
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            icon: 'ic_stat_logo',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        payload: "$id-$status");
  });

  //when open app
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Notification bosilganda ishlaydi
    final id = message.data['id'] ?? "";
    final status = message.data["status"] ?? "";
    {
      if ([
        "FINISHED",
        "CANCELED_BY_CLIENT",
        "CANCELED_BY_SCORING",
        "CANCELED_BY_DAILY"
      ].contains(status)) {
        rootNavigatorKey.currentContext
            ?.go('/application', extra: {"id": int.tryParse(id) ?? 0});
      } else {
        rootNavigatorKey.currentContext
            ?.go('/singleApplication', extra: {"id": int.tryParse(id) ?? 0});
      }
    }
  });
}
