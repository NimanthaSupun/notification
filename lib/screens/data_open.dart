import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class DataOpenr extends StatelessWidget {
  DataOpenr({super.key});

  Map<String, dynamic> payload = {};

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      payload = data.data;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications Recived"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Name: ${payload['name']}"
            ),
            Text("Age: ${payload['age']}")
          ],
        ),
      ),
    );
  }
}