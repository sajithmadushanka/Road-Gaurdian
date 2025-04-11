import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
        if (isMultiple) {
          final pickedFiles = await _picker.pickMultiImage(
            imageQuality: 100,
            maxWidth: 800,
            maxHeight: 800,
          );
          if (pickedFiles.isNotEmpty) {
            images.addAll(pickedFiles);
            notifyListeners();
          }
        } else {
          final pickedFile = await _picker.pickImage(
            source: source,
            imageQuality: 100,
            maxWidth: 800,
            maxHeight: 800,
          );
          if (pickedFile != null) {
            images.add(pickedFile); // Add single image to list
            notifyListeners();
          }
        }
      }
      // camara -----------------------------
      else {
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          images.add(pickedFile); // Add single image to list
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

  Future<bool> submitReport(String title, String description) async {
    if (kDebugMode) {
      print("Report submitted with title: $title");
      print("Description: $description");
      print("Selected image: ${images.map((e) => e.path).toList()}");

      // firebase logic
      try {
        setLoading(true);
        final firestore = FirebaseFirestore.instance;
        final storage = FirebaseStorage.instance;

        // Upload images to Firebase Storage
        List<String> imageUrls = [];

        for (var image in images) {
          final file = File(image.path);
          final fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final storageRef = storage.ref().child('reports/$fileName');
          await storageRef.putFile(file);
          final downloadUrl = await storageRef.getDownloadURL();
          imageUrls.add(downloadUrl);
        }

        // Save report data to Firestore
        await firestore.collection('reports').add({
          'title': title,
          'description': description,
          'images': imageUrls,
          'timestamp': FieldValue.serverTimestamp(),
        });
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
