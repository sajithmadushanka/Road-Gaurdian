import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:road_gurdian/features/auth/model/user_model.dart';


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
}
