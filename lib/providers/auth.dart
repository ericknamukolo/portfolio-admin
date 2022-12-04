import 'package:flutter/material.dart';
import 'package:portfolio_admin/constants/constants.dart';
import 'package:portfolio_admin/screens/nav_bar.dart';
import 'package:portfolio_admin/screens/sign_in_screen.dart';

class Auth {
  static Future<void> signIn(
      {required String email,
      required String pwd,
      required BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pwd);
      final fcmToken = await firebaseMessaging.getToken();
      await adminRef.child('fcmToken').set(fcmToken);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await firebaseAuth.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
    } catch (e) {
      throw e;
    }
  }
}
