import 'package:flutter/foundation.dart';
import 'package:portfolio_admin/models/project.dart';

import '../constants/constants.dart';

class Projects with ChangeNotifier {
  Future<void> addProject(Project proj) async {
    try {
      Map<String, dynamic> dataMap = {
        'name': proj.name,
        'description': proj.des,
        'type': proj.type,
        'playstore_link': proj.googleLink,
        'github_link': proj.githubLink,
        'external_link': proj.externalLink,
        'created_at': DateTime.now().toIso8601String(),
      };
      await adminRef.child('projects').push().set(dataMap);
    } catch (e) {
      throw e;
    }
  }
}
