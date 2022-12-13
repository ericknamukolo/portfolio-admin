import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/constants/constants.dart';
import 'package:portfolio_admin/models/noti_obj.dart';
import 'package:portfolio_admin/providers/noti.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/text.dart';

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
        icon = Iconsax.favorite_chart5;
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

    String getDeviceModel(String deviceData) {
      String modelData = deviceData.split('(')[1];
      String model = '';
      if (modelData.contains('Linux')) {
        String version = modelData.split(';')[1];
        String dev = modelData.split(';')[2].split(')')[0];
        model = '$dev, $version';
      } else if (modelData.contains('Windows')) {
        String os = modelData.split(';')[0];
        String bits = modelData.split(';')[1];
        model = '$os, $bits';
      } else if (modelData.contains('iPhone')) {
        model = modelData.split(';')[0];
      } else {
        model = 'Unkown';
      }
      return model;
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
                margin: const EdgeInsets.only(left: 6.0),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(getDeviceModel(notification.device),
                    style: kBodyTextStyleWhite.copyWith(fontSize: 10)),
                color: kSecondaryColor,
              ),
              const Spacer(),
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
