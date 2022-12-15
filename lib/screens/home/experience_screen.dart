import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/cutsom_app_bar.dart';

class ExperienceScreen extends StatelessWidget {
  static const routeName = '/experience-screen';
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Work Experience', showLeading: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(children: []),
    );
  }
}
