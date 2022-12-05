import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_admin/constants/colors.dart';
import 'package:portfolio_admin/providers/auth.dart';
import 'package:portfolio_admin/widgets/custom_button.dart';
import 'package:portfolio_admin/widgets/custom_loading.dart';
import 'package:portfolio_admin/widgets/custom_text_field.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../widgets/custom_toast.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Visibility(visible: _isLoading, child: CustomLoading()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 40),
                child: const AvatarGlow(
                  endRadius: 160.0,
                  animate: true,
                  glowColor: kPrimaryColor,
                  repeat: true,
                  duration: Duration(milliseconds: 2000),
                  child: CircleAvatar(
                    foregroundImage: AssetImage('assets/images/logo.png'),
                    backgroundColor: Colors.white,
                    radius: 90,
                  ),
                ),
              ),
              CustomTextField(
                  hint: 'Email', preIcon: Icons.email_rounded, data: _email),
              CustomTextField(
                  hint: 'Password', preIcon: Icons.lock, data: _pwd, obs: true),
              CustomButton(
                btnText: 'Sign In',
                isLoading: _isLoading,
                click: () async {
                  try {
                    setState(() => _isLoading = true);
                    await Auth.signIn(
                      context: context,
                      email: _email.text.trim(),
                      pwd: _pwd.text.trim(),
                    );
                  } catch (e) {
                    BotToast.showCustomNotification(
                        duration: Duration(seconds: 4),
                        toastBuilder: (context) => CustomToast(
                              message: e.toString().split(']')[1],
                              type: 'error',
                            ));
                    setState(() => _isLoading = false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
