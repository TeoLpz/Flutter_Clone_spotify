import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handlerBackgroundMessage(RemoteMessage message) async {
  print('Background message received!');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class MessageApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage);
  }
}
