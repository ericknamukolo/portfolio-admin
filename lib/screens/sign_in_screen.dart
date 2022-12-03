import 'package:flutter/material.dart';
import 'package:portfolio_admin/constants/colors.dart';
import 'package:portfolio_admin/widgets/custom_button.dart';
import 'package:portfolio_admin/widgets/custom_text_field.dart';
import 'package:avatar_glow/avatar_glow.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   boxShadow: [
              //     BoxShadow(
              //       color: const Color(0xff000000).withOpacity(0.12),
              //       blurRadius: 6.0,
              //       offset: const Offset(0.0, 3.0),
              //     )
              //   ],
              // ),
              child: const AvatarGlow(
                endRadius: 160.0,
                animate: true,
                glowColor: kPrimaryColor,
                repeat: true,
                duration: Duration(milliseconds: 2000),
                // repeatPauseDuration: Duration(milliseconds: 30),
                child: CircleAvatar(
                  foregroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.white,
                  radius: 90,
                ),
              ),
            ),
            CustomTextField(hint: 'Password', preIcon: Icons.lock),
            CustomTextField(hint: 'Email', preIcon: Icons.email_rounded),
            CustomButton(btnText: 'Sign In', click: () {}),
          ],
        ),
      ),
    );
  }
}
