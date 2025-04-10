import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportViewModel extends ChangeNotifier {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];

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
      // Optionally, you can show a dialog to the user explaining they need to go to app settings.
      openAppSettings();
    } else {
      if (kDebugMode) print("Permission denied for $source");
    }
  }

  void submitReport(String title, String description) {
    print("Report submitted: $title - $description with images: $images");
    // In a real application, you would handle the image upload and report submission here.
  }
}
