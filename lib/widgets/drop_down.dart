// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    Key? key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.title,
  }) : super(key: key);

  final String hint;
  final String? title;
  final Function(String?) onChanged;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 48,
      decoration: BoxDecoration(
          border: Border.all(color: kGreyColor, width: 1.0),
          borderRadius: BorderRadius.circular(4.0)),
      child: DropdownButton(
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        hint: Text(hint, style: kHintTextStyle),
        isExpanded: true,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: kBodyTextStyleGrey),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
