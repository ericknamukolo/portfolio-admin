import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users');

SharedPreferences? prefs;

var logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    printTime: true,
    printEmojis: true,
  ),
);
