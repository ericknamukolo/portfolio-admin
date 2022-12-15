import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/noti.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';
import 'package:portfolio_admin/widgets/home/notification_card.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import '../../constants/colors.dart';
import '../../models/noti_obj.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/home/category_card.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications-screen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isLoading = true;
  final GroupedItemScrollController itemScrollController =
      GroupedItemScrollController();

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () {
          itemScrollController.scrollTo(
            index: 0,
            curve: Curves.easeOut,
            duration: Duration(seconds: 1),
          );
        },
        child: Icon(
          Iconsax.arrow_up_24,
          color: Colors.white,
        ),
      ),
      appBar: CustomAppBar(title: 'Notifications', showLeading: true),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor, size: 50.0),
            )
          : Consumer<Noti>(
              builder: (context, data, __) => Container(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 0),
                        child: Row(
                          children: data.categories
                              .map((noti) => CategoryCard(noti: noti))
                              .toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: StickyGroupedListView<NotiObj, DateTime>(
                        itemScrollController: itemScrollController,
                        elements: data.notifications,
                        order: StickyGroupedListOrder.DESC,
                        groupBy: (element) => DateTime(
                          element.date.year,
                          element.date.month,
                          element.date.day,
                        ),
                        groupSeparatorBuilder: ((element) => getDate(element)),
                        itemComparator: (a, b) => a.date.compareTo(b.date),
                        itemBuilder: ((context, element) =>
                            NotificationCard(notification: element)),
                        shrinkWrap: true,
                        floatingHeader: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Container getDate(NotiObj notiObj) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      height: 40,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.12),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          )
        ],
        borderRadius: BorderRadius.circular(40.0),
      ),
      alignment: Alignment.center,
      child: Text(
        '${DateFormat.yMMMEd().format(notiObj.date)}',
        style: kBodyTextStyleWhite,
      ),
    );
  }
}
