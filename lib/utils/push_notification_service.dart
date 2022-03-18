import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future initilizedApp() async {
    String token = await messaging.getToken() ?? "";
    // print(token);

    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static Future _onMessage(RemoteMessage message) async {
    print("Aplicativo en primer plano");
    print(message.data);
    print(message.notification!.title);
    print(message.notification!.body);
  }

  static Future _onBackgroundMessage(RemoteMessage message) async {
    print("Aplicativo en 2do plano");
  }

  static Future _onMessageOpenedApp(RemoteMessage message) async {
    print("Aplicativo esté cerrado");
  }
}
