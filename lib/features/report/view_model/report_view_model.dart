import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:road_gurdian/features/report/model/report_model.dart';
import 'package:road_gurdian/utils/img_compress.dart';
import 'package:road_gurdian/utils/location_helper.dart';
import 'package:uuid/uuid.dart';

class ReportViewModel extends ChangeNotifier {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];

  //----------- loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    await _handlePermissions(source: ImageSource.gallery, isMultiple: false);
  }

  Future<void> pickImageFromCamera() async {
    await _handlePermissions(source: ImageSource.camera, isMultiple: false);
  }

  // select multiple images
  Future<void> pickMultipleImages() async {
    await _handlePermissions(source: ImageSource.gallery, isMultiple: true);
  }

  // remove image
  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
      notifyListeners();
    }
  }

  void clearImages() {
    if (kDebugMode) print("clean image list");
    images.clear();
    notifyListeners();
  }

  Future<void> _handlePermissions({
    required ImageSource source,
    required bool isMultiple,
  }) async {
    Permission permission;
    if (source == ImageSource.gallery) {
      permission = Permission.photos;
    } else {
      permission = Permission.camera;
    }

    final status = await permission.request();

    if (status.isGranted) {
      if (source == ImageSource.gallery) {
        if (kDebugMode) print("Permission granted for $source");
        if (isMultiple) {
          final pickedFiles = await _picker.pickMultiImage(
            imageQuality: 100,
            maxWidth: 800,
            maxHeight: 800,
          );
          for (final file in pickedFiles) {
            final compressed = await compressXFile(file);
            if (kDebugMode) print("compressed image: ${compressed?.path}");
            if (compressed != null) images.add(compressed);
            if (kDebugMode) {
              print("picked file: ${file.path}");
              print("compressed file: ${compressed?.path}");
              print("imaged $images");
            }
          }
          notifyListeners();
        } else {
          final pickedFile = await _picker.pickImage(
            source: source,
            imageQuality: 100,
            maxWidth: 800,
            maxHeight: 800,
          );
          if (pickedFile != null) {
            final compressed = await compressXFile(pickedFile);
            if (compressed != null) images.add(compressed);
            notifyListeners();
          }
        }
      }
      // camara -----------------------------
      else {
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          final compressed = await compressXFile(pickedFile);
          if (compressed != null) images.add(compressed);
          notifyListeners();
        }
      }
    } else if (status.isPermanentlyDenied) {
      if (kDebugMode) {
        print(
          "Permission permanently denied for $source. Please open app settings to grant permission.",
        );
      }
      openAppSettings();
    } else {
      if (kDebugMode) print("Permission denied for $source");
    }
  }

  Future<bool> submitReport(
    String title,
    String description,
    BuildContext context,
    priority_level,
  ) async {
    if (kDebugMode) {
      print("Report submitted with title: $title");
      print("Description: $description");
      print("Selected image: ${images.map((e) => e.path).toList()}");

      // firebase logic
      try {
        setLoading(true);
        final firestore = FirebaseFirestore.instance;
        final storage = FirebaseStorage.instance;

        // Get current location
        final position = await LocationHelper.getCurrentLocation(
          context: context,
          onStatus: (msg) => print("[Location] $msg"),
        );
        if (position == null) {
          setLoading(false);
          return false; // Prevent saving with null location
        }

        // Upload images to Firebase Storage
        List<String> imageUrls = [];
        if (kDebugMode) {
          print("imagesList $images");
        }
        for (var image in images) {
          final file = File(image.path);
          final fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final storageRef = storage.ref().child('reports/$fileName');
          await storageRef.putFile(file);
          final downloadUrl = await storageRef.getDownloadURL();
          imageUrls.add(downloadUrl);
        }

        // Save report data to Firestore
      final ReportModel report = ReportModel(
          id: Uuid().v4(),
          userId: FirebaseAuth.instance.currentUser!.uid,
          title: title,
          description: description,
          priorityLevel: priority_level,
          location: GeoPoint(
            position.latitude,
            position.longitude,
          ),
          images: imageUrls,
          createdAt: DateTime.now(),
        );
        await firestore.collection('reports').add(report.toJson());
        if (kDebugMode) {
          print("Report submitted successfully");
        }

        // Clear the selected images after submission
        images.clear();
        notifyListeners();
        setLoading(false);
        return true;
      } catch (e) {
        setLoading(false);
        if (kDebugMode) {
          print("Error submitting report: $e");
        }
        return false; // Return false in case of an error
      }
    }
    return false; // Ensure a boolean value is always returned
  }
}
