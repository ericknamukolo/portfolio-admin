import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_admin/providers/noti.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../widgets/custom_toast.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications-screen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() => _isLoading = true);
      try {
        await Provider.of<Noti>(context, listen: false).fetchNotifications();
        setState(() => _isLoading = false);
      } catch (e) {
        BotToast.showCustomNotification(
            duration: Duration(seconds: 5),
            toastBuilder: (context) =>
                CustomToast(message: e.toString(), type: 'error'));
        setState(() => _isLoading = false);
      }
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications', showLeading: true),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor, size: 50.0),
            )
          : SizedBox(),
    );
  }
}
