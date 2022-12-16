import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../models/work.dart';

class Works with ChangeNotifier {
  static Future<List<dynamic>> readJsonCountries() async {
    final String response =
        await rootBundle.loadString('assets/json/countries.json');
    List<dynamic> data = await json.decode(response);
    return data;
  }

  static Future<void> addWork(Work work) async {
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
      };

      await adminRef.child('experience').push().set(dataMap);
    } catch (e) {
      throw e;
    }
  }
}
