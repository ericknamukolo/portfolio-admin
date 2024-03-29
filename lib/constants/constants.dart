import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_toast.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

DatabaseReference adminRef = FirebaseDatabase.instance.ref().child('admin');
DatabaseReference projectsRef = adminRef.child('projects');
PackageInfo? packageInfo;

SharedPreferences? prefs;

var logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    printTime: true,
    printEmojis: true,
  ),
);

class Links {
  static void goToLink(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}

class Toast {
  static void showToast({required String message, required ToastType type}) {
    BotToast.showCustomNotification(
        duration: Duration(seconds: 4),
        toastBuilder: (_) => CustomToast(message: message, type: type));
  }
}
