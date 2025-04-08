import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportViewModel extends ChangeNotifier {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    await _handlePermissions(source: ImageSource.gallery);
  }

  Future<void> pickImageFromCamera() async {
    await _handlePermissions(source: ImageSource.camera);
  }

  Future<void> _handlePermissions({required ImageSource source}) async {
    Permission permission = source == ImageSource.gallery
        ? Permission.photos
        : Permission.camera;

    if (await permission.request().isGranted) {
      final picked = await _picker.pickImage(source: source);
      if (picked != null) {
        selectedImage = File(picked.path);
        notifyListeners();
      }
    } else {
      if (kDebugMode) print("Permission denied for $source");
    }
  }

  void submitReport(String title, String description) {
    print("Report submitted: $title - $description");
  }
}
