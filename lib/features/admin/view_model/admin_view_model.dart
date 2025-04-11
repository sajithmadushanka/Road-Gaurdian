import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:road_gurdian/features/report/model/report_model.dart';

class AdminViewModel extends ChangeNotifier {
  List<ReportModel> allReports = [];

  int get totalReports => allReports.length;
  int get highPriorityCount =>
      allReports.where((r) => r.priorityLevel.toLowerCase() == 'high').length;

  Future<void> fetchAllReports() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('reports')
          .orderBy('createdAt', descending: true)
          .get();

      allReports = snapshot.docs
          .map((doc) => ReportModel.fromJson(doc.data()))
          .toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching admin reports: $e");
    }
  }
}
