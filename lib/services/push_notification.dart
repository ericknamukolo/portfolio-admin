import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/main.dart';

import '../constants/constants.dart';
import '../screens/nav_bar.dart';
import '../widgets/custom_toast.dart';

class PushNotification {
  // static Future inititialize(BuildContext context) async {
  //   await FirebaseMessaging.instance;
  //   await getToken();

  //   // onMessage: When the app is open and it receives a push notification
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     newMessage(context);
  //   });
  //   //
  //   //Add this function in the main function
  //   // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
  //   FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
  //     goToMessages(context);
  //   });

  //   // replacement for onResume: When the app is in the background and opened directly from the push notification.
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     goToMessages(context);
  //   });
  // }

  static void newMessage() {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 4),
      toastBuilder: (_) => CustomToast(message: 'New Message', type: 'success'),
    );
  }

  static goToMessages() {
    // Navigator.of(context).pushReplacement(CupertinoPageRoute(
    //     builder: (context) => HomeScreen(newMessageNotifcation: true)));
    navigatorKey.currentState!.push(CupertinoPageRoute(
        builder: (_) => HomeScreen(newMessageNotifcation: true)));
  }

  static getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await adminRef.child('fcmToken').set(token);
    FirebaseMessaging.instance.subscribeToTopic('admin');
  }
}
