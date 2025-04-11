import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> getCurrentLocation({
    required BuildContext context,
    Function(String)? onStatus,
  }) async {
    try {
      final hasPermission = await _handlePermission(context, onStatus: onStatus);
      if (!hasPermission) return null;

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (e) {
      onStatus?.call("Error: $e");
      return null;
    }
  }

  static Future<bool> _handlePermission(
    BuildContext context, {
    Function(String)? onStatus,
  }) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      onStatus?.call('Location services are disabled.');

      final openSettings = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enable Location'),
          content: const Text(
              'Location services are turned off. Please enable them to proceed.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );

      if (openSettings == true) {
        await Geolocator.openLocationSettings();
      }

      return false; // Don't continue until user enables location manually
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        onStatus?.call('Permission denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      onStatus?.call('Permission denied forever.');
      await Geolocator.openAppSettings();
      return false;
    }

    onStatus?.call('Permission granted.');
    return true;
  }
}
