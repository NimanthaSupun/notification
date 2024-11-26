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
          ],
        ),
      ),
    );
  }
}
