import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../constants/text.dart';
import '../../widgets/home/analytics_card.dart';
import '../../widgets/home/visits_card.dart';

class HomeNavScreen extends StatelessWidget {
  const HomeNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _analyticsStream =
        firebaseFirestore.collection('analytics').doc('data').snapshots();
    final Stream<QuerySnapshot> _messageStreams = firebaseFirestore
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();

    List<String> _analytics = [
      'cv',
      'fb',
      'github',
      'linkedIn',
      'playStore',
      'whatsApp'
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: StreamBuilder<DocumentSnapshot>(
          stream: _analyticsStream,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child:
                      Text('Something went wrong', style: kBodyTextStyleGrey));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60.0),
                child: LoadingAnimationWidget.stretchedDots(
                    color: kPrimaryColor, size: 35),
              ));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: VisitsCard(
                          title: 'Portfolio Visits',
                          count: snapshot.data!.get('visit')),
                    ),
                    SizedBox(width: 15),
                    StreamBuilder<QuerySnapshot>(
                        stream: _messageStreams,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Expanded(
                              child: Center(
                                  child: LoadingAnimationWidget.stretchedDots(
                                      color: kPrimaryColor, size: 20)),
                            );
                          }
                          return Expanded(
                            child: VisitsCard(
                                title: 'Messages',
                                count: snapshot.data!.docs.length),
                          );
                        }),
                  ],
                ),
                Text('Clicks', style: kBodyTitleTextStyleGrey),
                SizedBox(height: 6),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, i) {
                    int data = snapshot.data!.get(_analytics[i]);

                    return AnalyticsCard(count: data, title: _analytics[i]);
                  },
                  itemCount: _analytics.length,
                  shrinkWrap: true,
                ),
              ],
            );
          }),
    );
  }
}
