import 'package:location/location.dart';
class LocationService {
  double ? latitude;
  double ? longitude;
  Location location = Location();
  Future initLocationCheck() async {
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }
    var loc = await location.getLocation();
    latitude = loc.latitude;
    longitude = loc.longitude;
    return;
  } 
}
