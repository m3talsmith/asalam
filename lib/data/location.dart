import 'package:geolocator/geolocator.dart';

Position? _position;
bool _positionDenied = false;

const String errorServiceDisabled = 'Location service is disabled';
const String errorPermissionDenied = 'Location permission is denied';
const String errorPermissionPermanentlyDenied = 'Location permission is permanently denied';

class Location {

  static Position? get position => _position;
  static bool get positionDenied => _positionDenied;

  static loadPosition() async {
    _position = await Geolocator.getLastKnownPosition();
    if (_position != null) return;
    await resetPosition();
  }

  static resetPosition() async {
    var enabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();
    if (!enabled) return Future.error(errorServiceDisabled);
    if (permission == LocationPermission.deniedForever) {
      _positionDenied = true;
      return Future.error(errorPermissionPermanentlyDenied);
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _positionDenied = true;
        return Future.error(errorPermissionDenied);
      }
    }
    _positionDenied = false;
    _position = await Geolocator.getCurrentPosition();
  }
}