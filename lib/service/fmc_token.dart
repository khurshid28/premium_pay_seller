import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<String?> getFcmToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print('FCM Token: $token');
  }
  return token;
}
