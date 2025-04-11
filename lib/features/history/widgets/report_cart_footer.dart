import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:road_gurdian/utils/location_convert_helper.dart';
import 'package:road_gurdian/utils/map_helper.dart';

class ReportCardFooter extends StatelessWidget {
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  const ReportCardFooter({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: LocationHelperConvert.getReadableAddress(latitude, longitude),
      builder: (context, snapshot) {
        final locationText = snapshot.data ?? "Loading location...";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: Colors.blueAccent,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    locationText,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.blueAccent,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // button for open in map
                GestureDetector(
                  onTap: () => openInGoogleMaps(latitude, longitude),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.map, size: 20, color: Colors.blueAccent),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormat.yMMMd().add_jm().format(createdAt),
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
