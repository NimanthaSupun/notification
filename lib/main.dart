import 'package:flutter/material.dart';
import 'package:notify/notifications/local_notifications.dart';
import 'package:notify/screens/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize local notification service
  await LocalNotificationsService.init();

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
      },
    );
  }
}
