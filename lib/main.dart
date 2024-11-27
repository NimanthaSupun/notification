import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notify/firebase_options.dart';
import 'package:notify/notifications/local_notifications.dart';
import 'package:notify/notifications/push_notifications.dart';
import 'package:notify/screens/data_open.dart';
import 'package:notify/screens/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize local notification service
  await LocalNotificationsService.init();

  // initialized timezone
  tz.initializeTimeZones();

  // firebase initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //initialize the push notification service (PushNotificationsService)
  await PushNotificationsService.init();

  //listen for incoming messages in background
  FirebaseMessaging.onBackgroundMessage(
      PushNotificationsService.onBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (message.notification != null) {
      print("Background Notification Tapped");
      await PushNotificationsService.onBackgroundNotificationTapped(
        message,
        navigatorKey,
      );
    }
  });

  // on foreground notification tapped
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await PushNotificationsService.onForeroundNotificationTapped(
      message,
      navigatorKey,
    );
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/data-screen", arguments: message);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(brightness: Brightness.light),
      title: 'Notification App',
      routes: {
        '/': (context) => const HomePage(),
        "/data-screen": (context) => DataOpenr(),
      },
    );
  }
}
