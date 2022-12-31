import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_admin/models/work.dart';
import 'package:portfolio_admin/providers/works.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';

class WorkCard extends StatelessWidget {
  final Work work;
  const WorkCard({
    Key? key,
    required this.work,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${work.position} @ ${work.company}',
                        style: kBodyTitleTextStyleGrey),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.timer, color: kPrimaryColor, size: 15),
                        SizedBox(width: 5),
                        Text(
                          '${DateFormat.yMMM().format(DateTime.parse(work.startDate))} - ${work.worksHere ? 'Present' : DateFormat.yMMM().format(DateTime.parse(work.startDate))}',
                          style: kBodyTextStyleGrey.copyWith(fontSize: 10.0),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Text(work.empType,
                              style:
                                  kBodyTextStyleWhite.copyWith(fontSize: 10)),
                          color: kSecondaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_pin,
                            color: kPrimaryColor, size: 15),
                        SizedBox(width: 5),
                        Text(
                          '${work.state}, ${work.country}',
                          style: kBodyTextStyleGrey.copyWith(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onLongPress: () async {
                  await Provider.of<Works>(context, listen: false)
                      .deleteWorkExp(work.id!);
                },
                child: Icon(
                  Icons.delete_rounded,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          //   SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: work.workDone
                .split('#')
                .toList()
                .map(
                  (workDone) => Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kPrimaryColor,
                          size: 6,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            workDone,
                            style: kBodyTextStyleGrey.copyWith(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
                '${DateFormat.yMMMEd().format(DateTime.parse(work.createdDate!))} at ${DateFormat.Hm().format(DateTime.parse(work.createdDate!))}',
                style: kBodyTextStyleGrey.copyWith(fontSize: 9)),
          ),
        ],
      ),
    );
  }
}
