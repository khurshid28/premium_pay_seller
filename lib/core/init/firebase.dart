import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(
    DrawableResourceAndroidBitmap('ic_large_logo'), // large icon
    largeIcon: DrawableResourceAndroidBitmap('ic_large_logo'),
    contentTitle: 'PremiumPay Notification',
    summaryText: 'Xabar matni',
  );
  // Notification details
  AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel', 'High Importance Notifications',
      icon: 'ic_stat_logo',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation);

  print("Background message received:");
  print("Message ID: ${message.messageId}");
  print("Notification title: ${message.notification?.title}");
  print("Notification body: ${message.notification?.body}");
  print("Data payload: ${message.data}");

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title ?? "PremiumPay Notification",
    message.notification?.body ?? "Sizga yangi xabar keldi",
    NotificationDetails(android: androidDetails),
  );
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
  await requestNotificationPermission();

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

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("Foreground message received:");
    print("Message ID: ${message.messageId}");
    print("Notification title: ${message.notification?.title}");
    print("Notification body: ${message.notification?.body}");
    print("Data payload: ${message.data}");

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
    );
  });
}
