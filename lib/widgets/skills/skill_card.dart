import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';

class SkillCard extends StatefulWidget {
  const SkillCard({
    Key? key,
  }) : super(key: key);

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isHidden = false;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isHidden ? .4 : 1,
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
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('JavaScript', style: kBodyTitleTextStyleGrey),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() => isHidden = !isHidden);
                  },
                  child: Icon(
                    isHidden ? Iconsax.eye_slash5 : Iconsax.eye4,
                    color: isHidden ? kGreyColor : kPrimaryColor,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {},
                  child: Icon(
                    Icons.edit,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'JavaScript, often abbreviated as JS, is a programming language that is one of the core technologies of the World Wide Web, alongside HTML and CSS.',
              style: kBodyTextStyleGrey.copyWith(fontSize: 11),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                  '${DateFormat.yMMMEd().format(DateTime.now())} at ${DateFormat.Hm().format(DateTime.now())}',
                  style: kBodyTextStyleGrey.copyWith(fontSize: 9)),
            ),
          ],
        ),
      ),
    );
  }
}
