import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';
import '../../widgets/messages/message_card.dart';
import '../../widgets/skills/skill_card.dart';

class SkillsNavScreen extends StatelessWidget {
  const SkillsNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000).withOpacity(0.12),
                    blurRadius: 6.0,
                    offset: const Offset(0.0, 3.0),
                  )
                ],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Skills', style: kTitleTextStyle),
                  SizedBox(height: 5),
                  Text('8', style: kTitleTextStyle),
                ],
              ),
            ),
            ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                return SkillCard();
              }),
              itemCount: 8,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
