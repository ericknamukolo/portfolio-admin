import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../models/work.dart';

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
      logger.i(data);
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
            isHidden: workData['is_hidden'],
            siteUrl: workData['site_url'],
            worksHere: workData['works_here'],
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
        'is_hidden': work.isHidden,
        'created_at': DateTime.now().toIso8601String(),
      };
      await adminRef.child('experience').push().set(dataMap);
      await fetchWorkData();
    } catch (e) {
      throw e;
    }
  }
}
