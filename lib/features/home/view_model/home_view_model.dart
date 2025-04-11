import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:road_gurdian/features/auth/model/user_model.dart';
import 'package:road_gurdian/features/report/model/report_model.dart';


class HomeViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AppUser? currentUser;
  bool isLoading = false;
  String? error;
  String? get userName => currentUser?.fullName;
  String? get userAddress => currentUser?.address;
  String? get userEmail => currentUser?.email;
  String? get userUid => currentUser?.uid;
  
  Future<void> fetchUserProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc = await _firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          currentUser = AppUser.fromJson(doc.data()!);
        } else {
          error = "User not found.";
        }
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // fetch all reports---------------------------
  List<ReportModel> allReports = [];
  bool isReportLoading = false;

  Future<void> fetchAllReports() async {
    isReportLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('reports')
          .orderBy('createdAt', descending: true)
          .get();

      allReports = snapshot.docs
          .map((doc) => ReportModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching all reports: $e");
    }

    isReportLoading = false;
    notifyListeners();
  }
}
