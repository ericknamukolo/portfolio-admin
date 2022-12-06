import 'package:flutter/foundation.dart';
import 'package:portfolio_admin/constants/constants.dart';

class Skills with ChangeNotifier {
  static Future<void> addSkill(String name, String description) async {
    Map<String, dynamic> dataMap = {
      'name': name,
      'des': description,
      'hidden': false,
      'img': null,
      'date': DateTime.now().toIso8601String(),
    };
    try {
      await adminRef.child('skills').push().set(dataMap);
    } catch (e) {
      throw e;
    }
  }
}
