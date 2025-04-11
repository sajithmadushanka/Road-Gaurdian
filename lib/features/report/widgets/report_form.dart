import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/routes.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/features/report/widgets/dropdown_priority_level.dart';
import 'package:road_gurdian/features/report/widgets/text_form_filed.dart';
import 'package:road_gurdian/utils/show_submission_dialog_helper.dart';
import 'package:road_gurdian/widgets/image_source_picker.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  var priority_level = "Low"; // default to low

  void setPriorityLevel(String value) {
    priority_level = value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final viewModel = Provider.of<ReportViewModel>(context, listen: false);
    if (kDebugMode) {
      print("isDark: $isDark");
    }
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              text: "Title",
              height: 60,
              controller: titleController,
              maxLines: 1,
            ),
            const SizedBox(height: 12),
            MyTextField(
              text: "Description",
              height: 120,
              controller: descriptionController,
              maxLines: 8,
            ),
            const SizedBox(height: 12),

            const SizedBox(height: 16),
            // Priority level dropdown
            Text(
              "Priority Level",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            DropdownPriorityLevel(
              onChanged: (value) {
                setPriorityLevel(value!);
              },
            ),
            const SizedBox(height: 16),

            // Upload image section
            Consumer<ReportViewModel>(
              builder: (context, viewModel, child) {
                final imagesList = viewModel.images;

                Widget buildImageTile({required Widget child}) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.grey : Colors.yellow,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: child,
                  );
                }

                if (imagesList.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      showImageSourcePicker(context, viewModel);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isDark
                                  ? Colors.grey
                                  : Theme.of(context).primaryColor,
                          width: 0.5,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Upload Photos",
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imagesList.length + 1,
                          itemBuilder: (context, index) {
                            if (index < imagesList.length) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: buildImageTile(
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(imagesList[index].path),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            viewModel.removeImage(index);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap:
                                    () => showImageSourcePicker(
                                      context,
                                      viewModel,
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: buildImageTile(
                                    child: Icon(
                                      Icons.add,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Tap the + to upload media. Max 3 files, 5MB each.",
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 12),
            const SizedBox(height: 20),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.primary,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result = await showSubmissionDialog(
                      context,
                      () async {
                        return await viewModel.submitReport(
                          titleController.text,
                          descriptionController.text,
                          context,
                          priority_level,
                        );
                      },
                    );

                    if (result && context.mounted) {
                      // Clear fields after success
                      titleController.clear();
                      descriptionController.clear();
                      viewModel.clearImages();

                      // Navigate to home
                      Navigator.pushReplacementNamed(context, AppRoutes.main);
                    }
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
