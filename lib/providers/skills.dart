import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_admin/constants/constants.dart';
import 'package:portfolio_admin/models/skill.dart';

import '../widgets/custom_toast.dart';

class Skills with ChangeNotifier {
  List<Skill> _skills = [];
  List<Skill> get skills => _skills;
  Future<void> addSkill(File icon, String name, String description) async {
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
      await fetchSkills();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchSkills() async {
    try {
      DatabaseEvent ref = await adminRef.child('skills').once();
      var data = (ref.snapshot.value as Map);
      List<Skill> _loadedSkills = [];

      data.forEach((key, skillData) {
        _loadedSkills.add(
          Skill(
            date: DateTime.parse(skillData['date']),
            id: key,
            des: skillData['des'],
            iconUrl: skillData['img'],
            isHidden: skillData['hidden'],
            name: skillData['name'],
          ),
        );
      });
      _skills = _loadedSkills;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> toggleVisibility(String id, bool state) async {
    await adminRef.child('skills').child(id).update({'hidden': !state});
    Skill selectedSkill = _skills.firstWhere((skill) => skill.id == id);
    selectedSkill.isHidden = !state;
    Toast.showToast(
        message: '${selectedSkill.name} is now ${state ? 'visible' : 'hidden'}',
        type: ToastType.success);
    notifyListeners();
  }

  Future<void> deleteSkill(String id) async {
    await adminRef.child('skills').child(id).remove();
    Skill selectedSkill = _skills.firstWhere((skill) => skill.id == id);
    _skills.remove(selectedSkill);
    notifyListeners();
  }
}
