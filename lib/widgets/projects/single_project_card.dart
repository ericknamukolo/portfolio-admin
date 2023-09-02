// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/widgets/projects/project_icon_btn.dart';

import '../../constants/colors.dart';
import '../../models/project.dart';
import '../../screens/projects/add_project_screen.dart';
import 'custom_chip.dart';

class SingleProjectCard extends StatelessWidget {
  final Project project;
  const SingleProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(AddProjectScreen.routeName, arguments: project),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: _screenWidth * .521,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: kPrimaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                project.cover,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    project.name,
                    style: kBodyTitleTextStyleGrey,
                  ),
                  Row(
                    children: [
                      ProjectIconBtn(
                          icon: MdiIcons.github,
                          link: project.githubLink!,
                          padding: 4),
                      ProjectIconBtn(
                          icon: MdiIcons.link,
                          link: project.externalLink!,
                          padding: 4),
                      ProjectIconBtn(
                          icon: MdiIcons.googlePlay,
                          link: project.playstoreLink!,
                          padding: 4),
                    ],
                  ),
                ],
              ),
              Text(
                project.description,
                style: kBodyTextStyleGrey.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 8),
              Wrap(
                  runSpacing: 10.0,
                  children: project.tech
                      .map((tech) => CustomChip(name: tech))
                      .toList()),
            ],
          ),
        ],
      ),
    );
  }
}
