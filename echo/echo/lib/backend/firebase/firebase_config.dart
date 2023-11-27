import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC_jq0vWdw7a8OX5DRUedEOS0kBkTioQEI",
            authDomain: "echofirebase-423a8.firebaseapp.com",
            projectId: "echofirebase-423a8",
            storageBucket: "echofirebase-423a8.appspot.com",
            messagingSenderId: "583062296155",
            appId: "1:583062296155:web:cfb447d745fc615964917e",
            measurementId: "G-F4WGY1PFDL"));
  } else {
    await Firebase.initializeApp();
  }
}
