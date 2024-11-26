import 'package:flutter/material.dart';
import 'package:notify/notifications/local_notifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                LocalNotificationsService.showInstanceNotification(
                  title: "Flutter by Nimantha",
                  body: "creating notifications",
                );
              },
              child: const Text("Show Instance notifications"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // sample shedule for the current time
                DateTime durationSample = DateTime.now().add(
                  const Duration(seconds: 5),
                );

                LocalNotificationsService.scheduleNotification(
                  title: "This is a schedule notifications",
                  body: "creating notifications",
                  scheduledDate: durationSample,
                );
              },
              child: const Text("schedule notifications"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotificationsService.showBigPictureNotification(
                  title: "This is a big picture notification",
                  body: "creating notification",
                  imageUrl: "@mipmap/ic_launcher",
                );
              },
              child: const Text(
                "Big Picture notifications",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
  
}
