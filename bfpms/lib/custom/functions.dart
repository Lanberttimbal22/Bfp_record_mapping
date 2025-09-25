import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Functions {
  Location location = Location();

  Future<LatLng> getLocation() async {
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return LatLng(0, 0);
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return LatLng(0, 0);
      }
    }

    locationData = await location.getLocation();

    return LatLng(locationData.latitude!, locationData.longitude!);
  }
}
