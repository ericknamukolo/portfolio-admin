import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_admin/constants/colors.dart';
import 'package:portfolio_admin/constants/constants.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/screens/nav_bar.dart';
import 'package:portfolio_admin/screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacementNamed(
          firebaseAuth.currentUser == null
              ? SignInScreen.routeName
              : HomeScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
              color: kPrimaryColor, size: 50.0),
          SizedBox(height: 10),
          Center(child: Text('Loading', style: kBodyTextStyleGrey)),
        ],
      ),
    );
  }
}
