import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:math';

int createUniqueId() {
  int random = Random().nextInt(99);
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  return int.parse('$timestamp$random');
}

Future<void> createEmergencyNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 4,
      channelKey: 'basic_channel',
      title: '${Emojis.building_hospital} Emergency Alert Nearby!!!',
      body: 'Shamsa Hafeez is calling for a lifesaver at Blue Moon Apt. ',
      bigPicture: 'asset://assets/Images/Image11.png',
      notificationLayout: NotificationLayout.BigPicture, 
    ),
  );
}
