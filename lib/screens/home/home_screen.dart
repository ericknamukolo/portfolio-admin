import 'package:flutter/material.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/auth.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Home',
          action: IconButton(
              onPressed: () => Auth.signOut(context: context),
              icon: Icon(Icons.logout_rounded))),
      body: Center(
        child: Text(
          'Home Screen',
          style: kBodyTextStyleGrey,
        ),
      ),
    );
  }
}
