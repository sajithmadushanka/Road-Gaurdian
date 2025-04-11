import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/features/admin/view_model/admin_view_model.dart';

class ReportDataTable extends StatelessWidget {
  const ReportDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AdminViewModel>(context);
    final reports = viewModel.allReports;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Reports",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            reports.isEmpty
                ? const Center(child: Text("No reports available"))
                : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    ),

                    border: TableBorder.all(color: Colors.grey.shade200),
                    columns: const [
                      DataColumn(label: Text("Title")),
                      DataColumn(label: Text("Priority")),
                      DataColumn(label: Text("User ID")),
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Actions")),
                    ],
                    rows:
                        reports.map((r) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  r.title,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        r.priorityLevel.toLowerCase() == 'high'
                                            ? Colors.red.withOpacity(0.2)
                                            : r.priorityLevel.toLowerCase() ==
                                                'medium'
                                            ? Colors.orange.withOpacity(0.2)
                                            : Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    r.priorityLevel,
                                    style: TextStyle(
                                      color:
                                          r.priorityLevel.toLowerCase() ==
                                                  'high'
                                              ? Colors.red
                                              : r.priorityLevel.toLowerCase() ==
                                                  'medium'
                                              ? Colors.orange
                                              : Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  r.userId.substring(0, 6) + '...',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              DataCell(
                                Text(
                                  r.createdAt!.toLocal().toString().split(
                                    ".",
                                  )[0],
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    Tooltip(
                                      message: "Delete",
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          _confirmDelete(context, r.title);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String title) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Delete Report"),
            content: Text("Are you sure you want to delete \"$title\"?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: delete from Firestore
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }
}
