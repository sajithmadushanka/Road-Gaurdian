import 'package:geocoding/geocoding.dart';

class LocationHelperConvert {
  static Future<String> getReadableAddress(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.country}";
      }
    } catch (e) {
      print("Geocoding failed: $e");
    }
    return "Unknown location";
  }
}
