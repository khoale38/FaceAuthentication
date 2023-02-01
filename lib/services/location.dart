import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LocationAuth {
  static Future<bool> checkLocation(double latitude, double longitude) async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      final currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;

      if (latitude.toStringAsFixed(3) == lat.toStringAsFixed(3) && longitude.toStringAsFixed(3) == lng.toStringAsFixed(3)) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}

Future<bool> checkStaticLocation() async {
  const double staticLatitude = 37.4219999;
  const double staticLongitude = -122.0840575;

  return await LocationAuth.checkLocation(staticLatitude, staticLongitude);
}
