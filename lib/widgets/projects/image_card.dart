import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Function() click;
  final Widget child;
  final bool removeBgColor;
  const ImageCard({
    super.key,
    required this.click,
    required this.child,
    this.removeBgColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: removeBgColor ? null : Color(0xffF6F8FA),
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
