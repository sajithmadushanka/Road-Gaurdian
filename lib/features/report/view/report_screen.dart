import 'package:flutter/material.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/features/report/widgets/report_form.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ReportViewModel();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Report', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ReportForm(viewModel: viewModel),
        ),
      ),
    );
  }
}
