import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_admin/constants/constants.dart';

class Skills with ChangeNotifier {
  static Future<void> addSkill(
      File icon, String name, String description) async {
    try {
      UploadTask uploadTask;
      final iconPath = 'skill-icons/${name}';
      final ref = firebaseStorage.ref().child(iconPath);
      uploadTask = ref.putFile(icon);
      final snapshot = await uploadTask.whenComplete(() {});
      final iconUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> dataMap = {
        'name': name,
        'des': description,
        'hidden': false,
        'img': iconUrl,
        'date': DateTime.now().toIso8601String(),
      };

      await adminRef.child('skills').push().set(dataMap);
    } catch (e) {
      throw e;
    }
  }
}
