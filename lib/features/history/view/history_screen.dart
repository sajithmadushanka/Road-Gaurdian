import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/features/history/view_model/history_view_model.dart';
import 'package:road_gurdian/features/history/widgets/report_card.dart';
import 'package:road_gurdian/features/report/model/report_model.dart';
import 'package:intl/intl.dart';
import 'package:road_gurdian/shared/layout/bottom_nav.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoryViewModel()..fetchUserReports(),
      child: const HistoryContent(),
    );
  }
}

class HistoryContent extends StatelessWidget {
  const HistoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HistoryViewModel>(context);
    final reports = viewModel.userReports;

    return Scaffold(
      appBar: AppBar(title: const Text("My Reports"), centerTitle: true),
      body:
          viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : reports.isEmpty
              ? const Center(child: Text("No reports submitted yet."))
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return ReportCard(report: report);
                },
              ),
    );
  }
}

// class ReportCard extends StatelessWidget {
//   final ReportModel report;
//   const ReportCard({super.key, required this.report});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Title and Priority
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     report.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Chip(
//                   label: Text(report.priorityLevel),
//                   backgroundColor:
//                       report.priorityLevel == "High"
//                           ? Colors.redAccent
//                           : report.priorityLevel == "Medium"
//                           ? Colors.orangeAccent
//                           : Colors.green,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),

//             /// Description
//             Text(
//               report.description,
//               style: const TextStyle(color: Colors.black87),
//             ),

//             /// Image
//             if (report.images != null && report.images!.isNotEmpty) ...[
//               const SizedBox(height: 12),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   report.images!.first,
//                   height: 160,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ],

//             /// Created at
//             const SizedBox(height: 12),
//             Text(
//               "Submitted on: ${report.createdAt != null ? DateFormat.yMMMd().add_jm().format(report.createdAt!) : 'Unknown date'}",
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
