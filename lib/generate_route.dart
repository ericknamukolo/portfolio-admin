import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/screens/home/notifications_screen.dart';
import 'package:portfolio_admin/screens/nav_bar.dart';
import 'package:portfolio_admin/screens/sign_in_screen.dart';
import 'package:portfolio_admin/screens/skills/add_skill_screen.dart';
import 'package:portfolio_admin/screens/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
          builder: (_) => const SplashScreen(), settings: settings);
    case SignInScreen.routeName:
      return CupertinoPageRoute(
          builder: (_) => const SignInScreen(), settings: settings);
    case HomeScreen.routeName:
      return CupertinoPageRoute(
          builder: (_) => const HomeScreen(), settings: settings);
    case AddSkillScreen.routeName:
      return CupertinoPageRoute(
          builder: (_) => const AddSkillScreen(), settings: settings);
    case NotificationsScreen.routeName:
      return CupertinoPageRoute(
          builder: (_) => const NotificationsScreen(), settings: settings);
  }
  return CupertinoPageRoute(
      builder: (_) => const SplashScreen(), settings: settings);
}
