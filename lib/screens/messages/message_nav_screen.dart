import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_admin/constants/colors.dart';
import 'package:portfolio_admin/constants/text.dart';

import '../../constants/constants.dart';
import '../../widgets/messages/message_card.dart';

class MessageNavScreen extends StatelessWidget {
  const MessageNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _messageStreams = firebaseFirestore
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        child: StreamBuilder<QuerySnapshot>(
            stream: _messageStreams,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('Something went wrong',
                        style: kBodyTextStyleGrey));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.stretchedDots(
                        color: kPrimaryColor, size: 35));
              }
              return Column(
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
                        Text('Messages', style: kTitleTextStyle),
                        SizedBox(height: 5),
                        Text(snapshot.data!.docs.length.toString(),
                            style: kTitleTextStyle),
                      ],
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      Map messageData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      logger.i(messageData);
                      return MessageCard(data: messageData);
                    }),
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
