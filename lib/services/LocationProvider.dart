import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  String location = "Location";
  late Position position;
  late List<Placemark> placemarks;
  Map coordinates = {" lat": '', "long": ""};

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
   getLocation(context) async {
   await _handleLocationPermission(context).then((value) async {
      if (value) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print(
            '${position.latitude.toString()} ${position.latitude.toString()}');
        coordinates["lat"] = position.latitude.toString();
        coordinates['long'] = position.longitude.toString();
        print(
            "==============================================================================");
        if (kDebugMode) {
          print(
              '${position.latitude.toString()}${position.latitude.toString()}');
        }
        print(
            "==============================================================================");
        placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        location = '${placemarks[2].street},${placemarks[2].locality!}';
        notifyListeners();
      }
    });
  }
}
