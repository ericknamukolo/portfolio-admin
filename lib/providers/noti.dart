import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_admin/models/category.dart';
import 'package:portfolio_admin/models/noti_obj.dart';

import '../constants/constants.dart';
import '../widgets/custom_toast.dart';

class Noti with ChangeNotifier {
  List<NotiObj> _notifications = [];
  List<NotiObj> _loadedNotifications = [];
  List<NotiObj> get notifications => _notifications;
  Future<void> fetchNotifications() async {
    try {
      _loadedNotifications.clear();

      categories.forEach((cate) {
        cate.isSelected = false;
      });
      categories.first.isSelected = true;
      DatabaseEvent ref = await adminRef.child('notifications').once();
      var data = (ref.snapshot.value as Map);
      data.forEach((key, notiData) {
        _loadedNotifications.add(
          NotiObj(
            date: DateTime.parse(notiData['date']),
            id: key,
            title: notiData['title'],
            body: notiData['body'],
            category: notiData['category'],
            device: notiData['device_info'] ?? 'no data',
          ),
        );
      });
      _notifications = _loadedNotifications;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> deleteNotification(String id) async {
    await adminRef.child('notifications').child(id).remove();
    NotiObj selectedNoti = _notifications.firstWhere((noti) => noti.id == id);
    _notifications.remove(selectedNoti);
    BotToast.showCustomNotification(
        duration: Duration(seconds: 5),
        toastBuilder: (context) =>
            CustomToast(message: 'Notification deleted', type: 'success'));
    notifyListeners();
  }

  List<NotiCategory> categories = [
    NotiCategory(name: 'all', isSelected: true),
    NotiCategory(name: 'visit'),
    NotiCategory(name: 'cv'),
    NotiCategory(name: 'github'),
    NotiCategory(name: 'fb'),
    NotiCategory(name: 'linkedIn'),
    NotiCategory(name: 'playStore'),
    NotiCategory(name: 'whatsApp'),
  ];

  void selectCard(NotiCategory noti) {
    categories.forEach((cate) {
      cate.isSelected = false;
    });
    noti.isSelected = !noti.isSelected;
    if (noti.name != 'all') {
      _notifications = _loadedNotifications
          .where((element) => noti.name == element.category)
          .toList();
    } else {
      _notifications = _loadedNotifications;
    }
    logger.i(notifications);
    notifyListeners();
  }
}
