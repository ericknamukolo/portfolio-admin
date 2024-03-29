import 'package:flutter/material.dart';
import 'package:portfolio_admin/constants/text.dart';

import '../../constants/colors.dart';

class CustomChip extends StatelessWidget {
  final String name;
  final VoidCallback? delete;
  const CustomChip({Key? key, required this.name, this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: delete,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(name,
            style: kBodyTextStyleGrey.copyWith(
                fontSize: 11, color: kPrimaryColor)),
        decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(.1),
            border: Border.all(
              color: kPrimaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(50.0)),
      ),
    );
  }
}
