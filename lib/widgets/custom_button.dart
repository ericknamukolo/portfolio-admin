import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.btnText,
    required this.click,
    this.color,
    this.isLoading = false,
  }) : super(key: key);

  final String btnText;
  final Function() click;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(btnText, style: kBodyTextStyleWhite),
      onPressed: isLoading ? null : click,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(40),
        backgroundColor: color ?? kPrimaryColor,
      ),
    );
  }
}
