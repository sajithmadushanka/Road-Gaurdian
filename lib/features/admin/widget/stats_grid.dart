import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/features/admin/view_model/admin_view_model.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AdminViewModel>(context);
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatCard(
          "Total Reports",
          viewModel.totalReports,
          Colors.blue,
          context,
        ),
        _buildStatCard(
          "High Priority",
          viewModel.highPriorityCount,
          Colors.redAccent,
          context,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, int count, Color color, context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 32,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
