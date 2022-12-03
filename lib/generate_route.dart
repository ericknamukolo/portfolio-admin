import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/screens/sign_in_screen.dart';
import 'package:portfolio_admin/screens/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
          builder: (_) => const SplashScreen(), settings: settings);
    case SignInScreen.routeName:
      return CupertinoPageRoute(
          builder: (_) => const SignInScreen(), settings: settings);
  }
  return CupertinoPageRoute(
      builder: (_) => const SplashScreen(), settings: settings);
}
