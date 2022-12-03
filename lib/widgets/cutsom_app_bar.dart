import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;
  final IconButton? action;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.action,
    this.showLeading = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kSecondaryColor,
      title: Text(title,
          style: kBodyTitleTextStyleGrey.copyWith(color: Colors.white)),
      centerTitle: true,
      //elevation: 10.0,
      leading: showLeading
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
              ),
            )
          : null,
      actions: [action != null ? action! : SizedBox()],
    );
  }
}
