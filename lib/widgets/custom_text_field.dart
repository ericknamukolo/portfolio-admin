import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData? preIcon;
  final IconButton? suffIcon;
  final bool ac;
  final TextCapitalization tc;
  final int? lines;

  final TextInputType? type;
  final bool obs;
  final TextEditingController? data;
  final Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    required this.hint,
    this.preIcon,
    this.data,
    this.lines = 1,
    this.onChanged,
    this.ac = true,
    this.obs = false,
    this.suffIcon,
    this.tc = TextCapitalization.none,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        onChanged: onChanged,
        controller: data,
        obscureText: obs,
        autocorrect: ac,
        textCapitalization: tc,
        keyboardType: type,
        textAlignVertical: TextAlignVertical.center,
        style: kBodyTextStyleGrey,
        cursorColor: kPrimaryColor,
        maxLines: lines,
        decoration: InputDecoration(
          fillColor: Color(0xffF0F0F0),
          prefixStyle: kBodyTextStyleGrey,
          border: InputBorder.none,
          filled: true,
          hintText: hint,
          hintStyle: kHintTextStyle,
          prefixIcon: preIcon == null
              ? null
              : Icon(
                  preIcon,
                  color: kSecondaryColor,
                ),
          suffixIcon: suffIcon,
        ),
      ),
    );
  }
}
