import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:road_gurdian/features/report/model/report_model.dart';

class HistoryViewModel extends ChangeNotifier {
  final List<ReportModel> _userReports = [];
  List<ReportModel> get userReports => _userReports;

  bool isLoading = false;

  Future<void> fetchUserReports() async {
    isLoading = true;
    notifyListeners();

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final snapshot = await FirebaseFirestore.instance
          .collection('reports')
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .get();

      _userReports.clear();
      for (var doc in snapshot.docs) {
        _userReports.add(ReportModel.fromJson(doc.data()));
      }
    } catch (e) {
      print("Error fetching history: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
