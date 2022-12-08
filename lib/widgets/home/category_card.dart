import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/models/category.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../providers/noti.dart';

class CategoryCard extends StatelessWidget {
  final NotiCategory noti;
  const CategoryCard({
    Key? key,
    required this.noti,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon getIcon(String analyticsTitle) {
      Icon? icon;
      if (analyticsTitle == 'cv') {
        icon = Icon(
          Icons.download_rounded,
          color: !noti.isSelected ? kGreyColor : kSecondaryColor,
        );
      } else if (analyticsTitle == 'all') {
        icon = Icon(
          Iconsax.notification5,
          color: !noti.isSelected ? kGreyColor : kPrimaryColor,
        );
      } else if (analyticsTitle == 'fb') {
        icon = Icon(
          MdiIcons.facebook,
          color: !noti.isSelected ? kGreyColor : const Color(0xff4267B2),
        );
      } else if (analyticsTitle == 'github') {
        icon = Icon(
          MdiIcons.github,
          color: !noti.isSelected ? kGreyColor : const Color(0xff171515),
        );
      } else if (analyticsTitle == 'linkedIn') {
        icon = Icon(
          MdiIcons.linkedin,
          color: !noti.isSelected ? kGreyColor : const Color(0xff0A66C2),
        );
      } else if (analyticsTitle == 'playStore') {
        icon = Icon(
          MdiIcons.googlePlay,
          color: !noti.isSelected ? kGreyColor : const Color(0xff48ff48),
        );
      } else if (analyticsTitle == 'whatsApp') {
        icon = Icon(
          Icons.whatsapp_rounded,
          color: !noti.isSelected ? kGreyColor : const Color(0xff075e54),
        );
      } else {
        icon = Icon(
          Icons.whatsapp_rounded,
          color: !noti.isSelected ? kGreyColor : const Color(0xff075e54),
        );
      }
      return icon;
    }

    return GestureDetector(
      onTap: () {
        Provider.of<Noti>(context, listen: false).selectCard(noti);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: noti.isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.12),
                        blurRadius: 6.0,
                        offset: const Offset(0.0, 3.0),
                      )
                    ]
                  : [],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: getIcon(noti.name).color!.withOpacity(.15),
                shape: BoxShape.circle,
              ),
              child: getIcon(noti.name),
              padding: EdgeInsets.all(8),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.only(top: 10),
            width: noti.isSelected ? 35 : 0.0,
            height: 4,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
          )
        ],
      ),
    );
  }
}
