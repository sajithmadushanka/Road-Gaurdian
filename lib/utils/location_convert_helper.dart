import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

class LocationHelperConvert {
  static Future<String> getReadableAddress(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final street =
            (place.street != null &&
                    place.street!.contains(RegExp(r'[a-zA-Z]')))
                ? place.street
                : '';

        /// check whether street contains any letters to prevent showing  not identify road  in the address
        return "${street!.isNotEmpty ? '$street, ' : ''}${place.locality}, ${place.country}";
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting address: $e");
      }
    }
    return "Unknown location";
  }
}
