import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';

class CustomDropDownButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() click;
  final bool removeSpace;
  const CustomDropDownButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.click,
    this.removeSpace = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        margin: EdgeInsets.only(bottom: removeSpace ? 0 : 15),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        color: Color(0xffF0F0F0),
        child: Row(
          children: [
            Icon(
              icon,
              color: kSecondaryColor,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: kBodyTextStyleGrey.copyWith(
                color: label != 'Date of Birth'
                    ? kBodyTextStyleGrey.color
                    : kHintTextStyle.color,
              ),
            ),
            Spacer(),
            Icon(
              MdiIcons.chevronDown,
              color: kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
