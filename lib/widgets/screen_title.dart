import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String data;
  const ScreenTitle({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.12),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: kTitleTextStyle),
          SizedBox(height: 5),
          Text(data, style: kTitleTextStyle),
        ],
      ),
    );
  }
}
