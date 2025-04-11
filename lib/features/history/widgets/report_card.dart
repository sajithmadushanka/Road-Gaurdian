import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:road_gurdian/features/history/widgets/report_cart_footer.dart';
import 'package:road_gurdian/features/report/model/report_model.dart';

class ReportCard extends StatefulWidget {
  final ReportModel report;

  const ReportCard({super.key, required this.report});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  int _activeImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final report = widget.report;
    final images = report.images ?? [];

    // Priority color logic using colorScheme
    final priority = report.priorityLevel.toLowerCase();
    final Color priorityColor = switch (priority) {
      'high' => Colors.redAccent,
      'medium' => Colors.orangeAccent,
      _ => Colors.greenAccent,
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      elevation: 4,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    report.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    report.priorityLevel,
                    style: TextStyle(
                      color: priorityColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Description
            Text(
              report.description,
              style: textTheme.bodyMedium?.copyWith(
                height: 1.4,
                color: colorScheme.onBackground.withOpacity(0.7),
              ),
            ),

            /// Image Carousel
            if (images.isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                        itemCount: images.length,
                        onPageChanged:
                            (index) =>
                                setState(() => _activeImageIndex = index),
                        itemBuilder: (context, index) {
                          return Image.network(
                            images[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    if (images.length > 1)
                      Positioned(
                        bottom: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(images.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _activeImageIndex == index ? 10 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color:
                                    _activeImageIndex == index
                                        ? Colors.white
                                        : Colors.white38,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                      ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            /// Location & Time Footer
            ReportCardFooter(
              latitude: report.latitude,
              longitude: report.longitude,
              createdAt: report.createdAt ?? DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
