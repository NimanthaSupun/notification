import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) async {}

  static Future<void> init() async {
    // android
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    // ios
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    // combine ios and android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    // initialize plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  //todo:- show a notification (instance notication)
  static Future<void> showInstanceNotification({
    required String title,
    required String body,
  }) async {
    // define details
    const NotificationDetails platformChannelSpecification =
        NotificationDetails(
      // define android
      android: AndroidNotificationDetails(
        "channel_id",
        "channel_name",
        importance: Importance.max,
        priority: Priority.high,
      ),

      // define ios
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    // show notification
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecification,
    );
  }

  //todo:-  schedule a notifications
  
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    //define the notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      //define the android notification details
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.max,
        priority: Priority.high,
      ),

      //define the ios notification details
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    //schedule the notification

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
