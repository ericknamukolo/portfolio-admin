import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class IconHover extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Function() click;
  final double? padding;
  const IconHover({
    Key? key,
    required this.icon,
    required this.color,
    required this.click,
    this.padding = 10,
  }) : super(key: key);

  @override
  State<IconHover> createState() => _IconHoverState();
}

class _IconHoverState extends State<IconHover> {
  Color initialColor = const Color(0xffB3A595);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.icon, size: 20),
      onPressed: widget.click,
      color: kGreyColor,
    );
  }
}
