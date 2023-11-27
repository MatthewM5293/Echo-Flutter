import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

bool timeCheck(DateTime dateTime) {
  // Check if a DateTime is within 24 hours
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  return difference.inHours < 24;
}

bool checkValidUserName(String userName) {
  try {
    // Reference to the "users" collection in Firestore
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query to check if the username already exists
    QuerySnapshot querySnapshot = usersCollection
        .where('username', isEqualTo: userName)
        .get() as QuerySnapshot<Object?>;

    // If any documents are returned, the username is taken
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    // Handle any errors that might occur during the process
    return true; // Assume error and consider username as taken
  }
}
