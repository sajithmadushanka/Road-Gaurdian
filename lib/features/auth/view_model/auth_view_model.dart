import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  String? error;

  Future<void> signUp({
    required String name,
    required String address,
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
   
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
   
      final appUser = AppUser(
        uid: user.uid,
        fullName: name,
        address: address,
        email: email,
      );

      await _firestore.collection('users').doc(user.uid).set(appUser.toJson());

      onSuccess();
    } on FirebaseAuthException catch (e) {
      error = e.message ?? "An error occurred";
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }


  // Sign in method ------------------------
  Future<void> signIn({
  required String email,
  required String password,
  required VoidCallback onSuccess,
}) async {
  isLoading = true;
  error = null;
  notifyListeners();

  try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    onSuccess();
  } on FirebaseAuthException catch (e) {
    error = e.message ?? "Login failed";
  } catch (e) {
    error = e.toString();
  }

  isLoading = false;
  notifyListeners();
}

  // Sign out method ------------------------
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
