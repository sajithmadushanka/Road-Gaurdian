import 'package:flutter/material.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/features/report/widgets/report_form.dart';

class AddReportPopup extends StatelessWidget {
  const AddReportPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ReportViewModel();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Wrap(
        children: [
          const Center(
            child: Text(
              "Add New Report !",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          ReportForm(),
        ],
      ),
    );
  }
}
