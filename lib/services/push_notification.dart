import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/constants/constants.dart';
import 'package:portfolio_admin/main.dart';
import 'package:portfolio_admin/screens/sign_in_screen.dart';
import '../screens/nav_bar.dart';
import '../widgets/custom_toast.dart';

class PushNotification {
  static void newMessage() {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 4),
      toastBuilder: (_) => CustomToast(message: 'New Message', type: 'success'),
    );
  }

  static goToMessages() {
    navigatorKey.currentState!.push(
      CupertinoPageRoute(
        builder: (_) => firebaseAuth.currentUser != null
            ? HomeScreen(newMessageNotifcation: true)
            : SignInScreen(),
      ),
    );
  }
}
