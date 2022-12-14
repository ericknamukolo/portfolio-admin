import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_admin/constants/constants.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';

class MessageCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  final String? docId;
  const MessageCard({
    Key? key,
    required this.data,
    this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondaryColor,
                ),
                child: Icon(
                  Iconsax.user,
                  color: Colors.white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['sender'], style: kBodyTitleTextStyleGrey),
                  SelectableText(data['email'], style: kBodyTextStyleGrey),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onLongPress: () async {
                  await firebaseFirestore
                      .collection('messages')
                      .doc(docId)
                      .delete();
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
            data['message'],
            style: kBodyTextStyleGrey.copyWith(fontSize: 11),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
                '${DateFormat.yMMMEd().format(data['createdAt'].toDate())} at ${DateFormat.Hm().format(data['createdAt'].toDate())}',
                style: kBodyTextStyleGrey.copyWith(fontSize: 9)),
          ),
        ],
      ),
    );
  }
}
