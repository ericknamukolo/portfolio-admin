import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_admin/models/noti_obj.dart';

import '../constants/constants.dart';

class Noti with ChangeNotifier {
  List<NotiObj> _notifications = [];
  List<NotiObj> get notifications => _notifications;
  Future<void> fetchNotifications() async {
    try {
      DatabaseEvent ref = await adminRef.child('notifications').once();
      var data = (ref.snapshot.value as Map);
      List<NotiObj> _loadedNotifications = [];

      logger.i(data);

      data.forEach((key, notiData) {
        _loadedNotifications.add(
          NotiObj(
            date: DateTime.parse(notiData['date']),
            id: key,
            title: notiData['title'],
            body: notiData['body'],
            category: notiData['category'],
          ),
        );
      });
      _notifications = _loadedNotifications;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }
}
