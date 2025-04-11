import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/features/history/widgets/report_card.dart';
import 'package:road_gurdian/features/home/view_model/home_view_model.dart';
import 'package:road_gurdian/shared/layout/bottom_nav.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome! ${viewModel.userName ?? '...'}"),
        centerTitle: true,
      ),
      body:
          viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.allReports.isEmpty
              ? const Center(child: Text("No reports found"))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: viewModel.allReports.length,
                itemBuilder: (context, index) {
                  return ReportCard(report: viewModel.allReports[index]);
                },
              ),

    );
  }
}
