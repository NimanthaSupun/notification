import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:notify/notifications/local_notifications.dart';

class PushNotificationsService {
  //create an instance of the firebase messaging plugin
  static final _firebaseMessaging = FirebaseMessaging.instance;

  //initialize the firebase messaging (request permission for notifications)

  static Future<void> init() async {
    //request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    //check if the permission is granted
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
      return;
    }

    //get the FCM (Firebase Cloud Messagin) token from the device
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }

  //funtion that will listen for incoming messages in background
  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print('Background message: ${message.notification!.title}');
    }
  }

  // on background notification tapped function (pass the payload data to the message opener screen)
  static Future<void> onBackgroundNotificationTapped(
      RemoteMessage message, GlobalKey<NavigatorState> navigatorKey) async {
   
  }

  //handle foreground notifications
  static Future<void> onForeroundNotificationTapped(
    RemoteMessage message,
    GlobalKey<NavigatorState> navigatorKey,
  ) async {
    String payloadData = jsonEncode(message.data);

    print("Got the message in foreground");

    if (message.notification != null) {
      await LocalNotificationsService.showInstantNotificationWithPayload(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
      await navigatorKey.currentState!
          .pushNamed('/data-screen', arguments: message);
    }
  }
}
