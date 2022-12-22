import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:portfolio_admin/firebase_options.dart';
import 'package:portfolio_admin/generate_route.dart';
import 'package:portfolio_admin/providers/noti.dart';
import 'package:portfolio_admin/providers/skills.dart';
import 'package:portfolio_admin/providers/works.dart';
import 'package:portfolio_admin/services/push_notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/constants.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // PushNotification.goToMessages();
  flutterLocalNotificationsPlugin.show(0, message.notification!.title,
      message.notification!.body, NotificationDetails(android: details));
}

const AndroidNotificationDetails details = AndroidNotificationDetails(
    'high_importance_channel', 'High Importance Notifications',
    importance: Importance.max, enableLights: true);
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.notification.request();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
  );
  ;

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AndroidNotificationChannel(
          'high_importance_channel', 'High Importance Notifications',
          importance: Importance.max, enableLights: true));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, NotificationDetails(android: details));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    PushNotification.goToMessages();
  });

  runApp(const AdminPortfolio());
}

class AdminPortfolio extends StatelessWidget {
  const AdminPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Skills()),
        ChangeNotifierProvider(create: (context) => Noti()),
        ChangeNotifierProvider(create: (context) => Works()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Erick | Portfolio',
        theme: ThemeData(
          fontFamily: 'Montserrat',
        ),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
