import 'package:flutter/material.dart';
import 'package:portfolio_admin/constants/constants.dart';
import 'package:portfolio_admin/widgets/projects/icon_hover.dart';
import '../../constants/colors.dart';

class ProjectIconBtn extends StatelessWidget {
  final IconData icon;
  final String link;
  final double? padding;
  const ProjectIconBtn({
    Key? key,
    required this.icon,
    required this.link,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: link.isNotEmpty,
      child: IconHover(
        icon: icon,
        color: kPrimaryColor,
        click: () => Links.goToLink(link),
        padding: padding ?? 0,
      ),
    );
  }
}
