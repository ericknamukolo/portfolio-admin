import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio_admin/models/project.dart';

import '../constants/constants.dart';

class Projects with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects {
    return [..._projects];
  }

  Future<void> fetchAndSetProjects() async {
    try {
      DatabaseEvent ref = await projectsRef.once();
      var data = (ref.snapshot.value as Map);

      _projects = Project.fromJsonList(data);
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> addProject(Project proj) async {
    try {
      UploadTask uploadTask;
      final imgPath =
          'project-images/${proj.name}_${DateTime.now().toIso8601String()}';
      final ref = firebaseStorage.ref().child(imgPath);
      uploadTask = ref.putFile(proj.cover as File);
      final snapshot = await uploadTask.whenComplete(() {});
      final coverUrl = await snapshot.ref.getDownloadURL();
      List<String> images = await uploadImages(proj);
      Map<String, dynamic> dataMap = {
        'name': proj.name,
        'description': proj.description,
        'type': proj.type,
        'playstore_link': proj.playstoreLink,
        'github_link': proj.githubLink,
        'external_link': proj.externalLink,
        'created_at': DateTime.now().toIso8601String(),
        'cover_img': coverUrl,
        'images': images,
      };
      await adminRef.child('projects').push().set(dataMap);
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> uploadImages(Project proj) async {
    UploadTask uploadTask;
    List<String> images = [];
    for (XFile img in proj.images as List<XFile>) {
      final imgPath =
          'project-images/${proj.name}_${DateTime.now().toIso8601String()}';
      final ref = firebaseStorage.ref().child(imgPath);
      uploadTask = ref.putFile(File(img.path));
      final snapshot = await uploadTask.whenComplete(() {});
      final image = await snapshot.ref.getDownloadURL();
      images.add(image);
    }
    return images;
  }
}
