import 'package:flutter_workshop/domain/model/point.dart';
import 'package:location/location.dart' as l;

class LocationProvider {
  final location = l.Location();

  Stream<Location> observe() => location
      .onLocationChanged()
      .map((data) => Location(data.latitude, data.longitude));
}
