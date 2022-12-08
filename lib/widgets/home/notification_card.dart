import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/models/noti_obj.dart';
import 'package:portfolio_admin/providers/noti.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';
import '../../providers/skills.dart';

class NotificationCard extends StatelessWidget {
  final NotiObj notification;
  const NotificationCard({required this.notification, super.key});

  @override
  Widget build(BuildContext context) {
    IconData getIcon(String analyticsTitle) {
      IconData? icon;
      if (analyticsTitle == 'cv') {
        icon = Icons.download_rounded;
      } else if (analyticsTitle == 'visit') {
        icon = Iconsax.favorite_chart4;
      } else if (analyticsTitle == 'fb') {
        icon = MdiIcons.facebook;
      } else if (analyticsTitle == 'github') {
        icon = MdiIcons.github;
      } else if (analyticsTitle == 'linkedIn') {
        icon = MdiIcons.linkedin;
      } else if (analyticsTitle == 'playStore') {
        icon = MdiIcons.googlePlay;
      } else if (analyticsTitle == 'whatsApp') {
        icon = Icons.whatsapp_rounded;
      } else {
        icon = Icons.whatsapp_rounded;
      }
      return icon;
    }

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.12),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 6),
                  child:
                      Icon(getIcon(notification.category), color: kGreyColor)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.title, style: kBodyTitleTextStyleGrey),
                ],
              ),
              const Spacer(),
              // GestureDetector(
              //   onTap: () async {
              //     await Provider.of<Skills>(context, listen: false)
              //         .toggleVisibility(skill.id, skill.isHidden);
              //   },
              //   child: Icon(
              //     skill.isHidden ? Iconsax.eye_slash5 : Iconsax.eye4,
              //     color: skill.isHidden ? kGreyColor : kPrimaryColor,
              //   ),
              // ),

              GestureDetector(
                onLongPress: () async {
                  await Provider.of<Noti>(context, listen: false)
                      .deleteNotification(notification.id);
                },
                child: Icon(
                  Icons.delete_rounded,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            notification.body,
            style: kBodyTextStyleGrey.copyWith(fontSize: 11),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
                '${DateFormat.yMMMEd().format(notification.date)} at ${DateFormat.Hm().format(notification.date)}',
                style: kBodyTextStyleGrey.copyWith(fontSize: 9)),
          ),
        ],
      ),
    );
  }
}
