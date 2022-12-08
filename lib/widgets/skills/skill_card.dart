import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_admin/models/skill.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';
import '../../providers/skills.dart';

class SkillCard extends StatelessWidget {
  final Skill skill;
  const SkillCard({
    Key? key,
    required this.skill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: skill.isHidden ? .4 : 1,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.12),
              blurRadius: 6.0,
              offset: const Offset(0.0, 3.0),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 55,
                  width: 55,
                  child: Image.network(skill.iconUrl),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(skill.name, style: kBodyTitleTextStyleGrey),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await Provider.of<Skills>(context, listen: false)
                        .toggleVisibility(skill.id, skill.isHidden);
                  },
                  child: Icon(
                    skill.isHidden ? Iconsax.eye_slash5 : Iconsax.eye4,
                    color: skill.isHidden ? kGreyColor : kPrimaryColor,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onLongPress: () async {
                    await Provider.of<Skills>(context, listen: false)
                        .deleteSkill(skill.id);
                  },
                  child: Icon(
                    Icons.delete_rounded,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              skill.des,
              style: kBodyTextStyleGrey.copyWith(fontSize: 11),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                  '${DateFormat.yMMMEd().format(skill.date)} at ${DateFormat.Hm().format(skill.date)}',
                  style: kBodyTextStyleGrey.copyWith(fontSize: 9)),
            ),
          ],
        ),
      ),
    );
  }
}
