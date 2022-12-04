import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}

class PushNotification {
  static Future inititialize(BuildContext context) async {
    await FirebaseMessaging.instance;
    await getToken();

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('onBackgroundMessage');
    });
    //
    //Add this function in the main function
    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      logger.i('onBackgroundMessage');
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('onMessageOpenedApp');
    });
  }

  // static void newCrush(BuildContext context) {
  //   //playNotiSound();
  //   Provider.of<NotiState>(context, listen: false).hasNewCrush();
  //   BotToast.showCustomNotification(
  //     toastBuilder: (context) => CustomToast(
  //         message: 'Someone has a crush on you! 😍', type: 'success'),
  //   );
  // }

  static getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await adminRef.child('fcmToken').set(token);
    FirebaseMessaging.instance.subscribeToTopic('admin');
  }

  // static void playNotiSound() async {
  //   final player = AudioPlayer();
  //   await player.setAsset('assets/sounds/noti.mp3');
  //   await player.play();
  // }
}
