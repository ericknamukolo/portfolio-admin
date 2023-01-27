import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../models/work.dart';
import '../widgets/custom_toast.dart';

class Works with ChangeNotifier {
  List<Work> _work = [];
  List<Work> get work => _work;
  static Future<List<dynamic>> readJsonCountries() async {
    final String response =
        await rootBundle.loadString('assets/json/countries.json');
    List<dynamic> data = await json.decode(response);
    return data;
  }

  Future<void> fetchWorkData() async {
    try {
      DatabaseEvent ref = await adminRef.child('experience').once();
      var data = (ref.snapshot.value as Map);
      List<Work> _loadedWork = [];

      data.forEach((key, workData) {
        _loadedWork.add(
          Work(
            id: key,
            company: workData['company'],
            position: workData['position'],
            country: workData['country'],
            empType: workData['emp_type'],
            state: workData['state'],
            startDate: workData['start_date'],
            workDone: workData['work_done'],
            createdDate: workData['created_at'],
            endDate: workData['end_date'],
            siteUrl: workData['site_url'],
            worksHere: workData['works_here'],
            isHidden: workData['is_hidden'],
          ),
        );
      });
      _work = _loadedWork;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> addWork(Work work) async {
    try {
      Map<String, dynamic> dataMap = {
        'company': work.company,
        'position': work.position,
        'country': work.country,
        'state': work.state,
        'emp_type': work.empType,
        'site_url': work.siteUrl,
        'start_date': work.startDate,
        'end_date': work.endDate,
        'works_here': work.worksHere,
        'work_done': work.workDone,
        'created_at': DateTime.now().toIso8601String(),
        'is_hidden': false,
      };
      await adminRef.child('experience').push().set(dataMap);
      await fetchWorkData();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateWork(Work work) async {
    await adminRef.child('experience').child(work.id!).update({
      'company': work.company,
      'position': work.position,
      'country': work.country,
      'state': work.state,
      'emp_type': work.empType,
      'site_url': work.siteUrl,
      'start_date': work.startDate,
      'end_date': work.endDate,
      'works_here': work.worksHere,
      'work_done': work.workDone,
      //'created_at': work.createdDate,
      // 'is_hidden': work.isHidden,
    });
    fetchWorkData();
    notifyListeners();
  }

  Future<void> toggleVisibility(String id, bool state) async {
    await adminRef.child('experience').child(id).update({'is_hidden': !state});
    Work selectedWork = _work.firstWhere((work) => work.id == id);
    selectedWork.isHidden = !state;
    Toast.showToast(
        message:
            '${selectedWork.company} is now ${state ? 'visible' : 'hidden'}',
        type: ToastType.success);
    notifyListeners();
  }

  Future<void> deleteWorkExp(String id) async {
    await adminRef.child('experience').child(id).remove();
    Work selectedWork = _work.firstWhere((work) => work.id == id);
    work.remove(selectedWork);
    notifyListeners();
  }
}
