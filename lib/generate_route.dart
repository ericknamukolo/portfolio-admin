import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/screens/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
          builder: (_) => const SplashScreen(), settings: settings);
  }
  return CupertinoPageRoute(
      builder: (_) => const SplashScreen(), settings: settings);
}
