import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/constants/ad_units.dart';
import 'package:portfolio_admin/screens/home/notifications_screen.dart';
import 'package:portfolio_admin/services/ad_manager.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';

class AnalyticsCard extends StatelessWidget {
  final int count;
  final String title;
  const AnalyticsCard({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getTitle(String analyticsTitle) {
      String title = '';
      if (analyticsTitle == 'cv') {
        title = 'CV';
      } else if (analyticsTitle == 'fb') {
        title = 'Facebook';
      } else if (analyticsTitle == 'github') {
        title = 'Github';
      } else if (analyticsTitle == 'linkedIn') {
        title = 'LinkedIn';
      } else if (analyticsTitle == 'playStore') {
        title = 'Play Store';
      } else if (analyticsTitle == 'whatsApp') {
        title = 'WhatsApp';
      }
      return title;
    }

    Icon getIcon(String analyticsTitle) {
      Icon? icon;
      if (analyticsTitle == 'cv') {
        icon = Icon(
          Icons.download_rounded,
          color: kPrimaryColor,
        );
      } else if (analyticsTitle == 'fb') {
        icon = Icon(
          MdiIcons.facebook,
          color: const Color(0xff4267B2),
        );
      } else if (analyticsTitle == 'github') {
        icon = Icon(
          MdiIcons.github,
          color: const Color(0xff171515),
        );
      } else if (analyticsTitle == 'linkedIn') {
        icon = Icon(
          MdiIcons.linkedin,
          color: const Color(0xff0A66C2),
        );
      } else if (analyticsTitle == 'playStore') {
        icon = Icon(
          MdiIcons.googlePlay,
          color: const Color(0xff48ff48),
        );
      } else if (analyticsTitle == 'whatsApp') {
        icon = Icon(
          MdiIcons.whatsapp,
          color: const Color(0xff075e54),
        );
      }
      return icon!;
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(NotificationsScreen.routeName);
        Future.delayed(Duration(seconds: 3)).then(
            (_) => AdManager.loadInterstitialAd(adUnit: AdUnits.interNotiAd));
      },
      child: Container(
        padding: EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: getIcon(title).color!.withOpacity(.15),
                shape: BoxShape.circle,
              ),
              child: getIcon(title),
              padding: EdgeInsets.all(8),
            ),
            Text(
              '$count',
              style: kBodyTextStyleGrey.copyWith(
                color: kSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(getTitle(title),
                style: kBodyTextStyleGrey.copyWith(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
