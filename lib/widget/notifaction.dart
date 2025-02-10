import 'package:flutter/material.dart';
import '../models/notifaction.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: notification.profileImage != null
              ? NetworkImage(notification.profileImage!)
              : null,
          child: notification.profileImage == null
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(notification.fullName),
        subtitle: const Text('New notification received'),
        trailing: const Icon(Icons.notifications_active),
      ),
    );
  }
}