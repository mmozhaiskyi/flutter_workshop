import 'package:flutter_workshop/config.dart';
import 'package:flutter_workshop/domain/model/point.dart';

class StaticMapsService {

  final Config _config;
  static const _defaultSize = '700x450';

  StaticMapsService(this._config);

  String path(Point point) {
    return
      'https://${_config.staticMapsUrl}/maps/api/staticmap?'
      'center=${point.location.lat},${point.location.lng}&'
      'size=$_defaultSize&'
      'zoom=16&'
      'key=${_config.mapsKey}&'
      'markers=${_buildMarker(point.location)}';
  }

  String _buildMarker(Location location) {
    final l = '${location.lat},${location.lng}';
    return 'color:red%7C$l';
  }
}
