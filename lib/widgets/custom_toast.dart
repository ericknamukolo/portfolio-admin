// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text.dart';

enum ToastType { success, error }

class CustomToast extends StatelessWidget {
  final String message;
  final Enum type;
  const CustomToast({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.12),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              message,
              softWrap: true,
              style: kBodyTextStyleGrey,
            ),
          ),
          Icon(
            type == ToastType.error ? Icons.error : Icons.check_circle,
            size: 20,
            color: type == ToastType.error ? kErrorColor : kSuccessColor,
          )
        ],
      ),
    );
  }
}
