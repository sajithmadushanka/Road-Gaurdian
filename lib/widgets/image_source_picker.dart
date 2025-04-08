import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/report/view_model/report_view_model.dart';

void showImageSourcePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take a Photo"),
            onTap: () {
              Navigator.pop(context);
              context.read<ReportViewModel>().pickImageFromCamera();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Choose from Gallery"),
            onTap: () {
              Navigator.pop(context);
              context.read<ReportViewModel>().pickImageFromGallery();
            },
          ),
        ],
      ),
    ),
  );
}
