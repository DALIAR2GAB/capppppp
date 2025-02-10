import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notifaction.dart';
import '../widget/notifaction.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: FutureBuilder(
        future: Provider.of<NotificationProvider>(context, listen: false).fetchNotification(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<NotificationProvider>(
              builder: (context, provider, child) {
                if (provider.notification != null) {
                  return NotificationWidget(notification: provider.notification!);
                } else {
                  return const Center(child: Text('No notifications available'));
                }
              },
            );
          }
        },
      ),
    );
  }
}