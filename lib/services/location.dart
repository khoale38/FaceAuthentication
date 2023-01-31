// import 'dart:async';
//
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LocationAuth {
//   static Future<bool> checkLocation(double latitude, double longitude) async {
//     try {
//       final currentLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//
//       final lat = currentLocation.latitude;
//       final lng = currentLocation.longitude;
//
//       if (latitude == lat && longitude == lng) {
//         return true;
//       } else {
//         return false;
//       }
//     } on PlatformException catch (e) {
//       print(e);
//       return false;
//     }
//   }
// }
