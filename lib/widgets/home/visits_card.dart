import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../constants/colors.dart';
import '../../constants/text.dart';

class VisitsCard extends StatelessWidget {
  final int count;
  final String title;
  const VisitsCard({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData getIcon(String titleData) {
      IconData icon;
      if (titleData == 'Messages') {
        icon = Iconsax.message5;
      } else if (titleData == 'Portfolio Visits') {
        icon = Iconsax.favorite_chart5;
      } else {
        icon = Icons.work_rounded;
      }
      return icon;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: kBodyTitleTextStyleGrey),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          width: double.infinity,
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
                  color: kPrimaryColor.withOpacity(.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getIcon(title),
                  color: kPrimaryColor,
                ),
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: EdgeInsets.all(8),
              ),
              Text(
                count.toString(),
                style: kBodyTextStyleGrey.copyWith(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              //Text(title, style: kBodyTextStyleGrey.copyWith(fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }
}
