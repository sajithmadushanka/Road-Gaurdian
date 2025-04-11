import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/features/admin/view_model/admin_view_model.dart';
import 'package:road_gurdian/features/admin/widget/report_data_table.dart';
import 'package:road_gurdian/features/admin/widget/stats_grid.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminViewModel()..fetchAllReports(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin Dashboard"),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    StatsGrid(),
                    SizedBox(height: 20),
                    ReportDataTable(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
