import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/features/report/widgets/text_form_filed.dart';
import 'package:road_gurdian/widgets/image_source_picker.dart';

class ReportForm extends StatefulWidget {
  final ReportViewModel viewModel;
  const ReportForm({super.key, required this.viewModel});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imagesList = widget.viewModel.images;
    print("item count------------------ ${imagesList.length}");
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

            // upload image button if not images available ---------------------
            Consumer<ReportViewModel>(
              builder: (context, viewModel, child) {
                final imagesList = viewModel.images;

                Widget buildImageTile({required Widget child}) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: child,
                  );
                }

                if (imagesList.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      showImageSourcePicker(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.yellow, width: 0.5),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Upload Photos",
                              style: TextStyle(color: Colors.white),
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
                                            viewModel.removeImage(
                                              index,
                                            ); // Ensure this method exists
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
                                onTap: () => showImageSourcePicker(context),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: buildImageTile(
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Tap the + to upload media. Max 3 files, 5MB each.",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 12),

            // Show images source picker button
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.viewModel.submitReport(
                      titleController.text,
                      descriptionController.text,
                    );
                    Navigator.pop(context);
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
