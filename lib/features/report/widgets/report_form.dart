import 'package:flutter/material.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/widgets/image_source_picker.dart';

class ReportForm extends StatefulWidget {
  final ReportViewModel viewModel;
  const ReportForm({required this.viewModel});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final image = widget.viewModel.selectedImage;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
            validator: (value) => value!.isEmpty ? "Title required" : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: "Description"),
            maxLines: 3,
            validator:
                (value) => value!.isEmpty ? "Description required" : null,
          ),
          const SizedBox(height: 16),

          // Show image preview and file name if available
          if (image != null) ...[
            Image.file(image, height: 150),
            const SizedBox(height: 8),
            Text("File: ${image.path.split('/').last}"),
          ],

          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.upload),
            label: const Text("Upload Image"),
            onPressed: () => showImageSourcePicker(context),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.viewModel.submitReport(
                  titleController.text,
                  descriptionController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
