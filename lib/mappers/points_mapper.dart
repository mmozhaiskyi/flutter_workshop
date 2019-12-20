import 'package:flutter_workshop/db/point_entity.dart';
import 'package:flutter_workshop/domain/model/point.dart';

class PointsMapper {
  static Point mapToPoint(PointEntity entity) {
    return Point(entity.id, entity.name, Location(entity.lat, entity.long),
        entity.address, entity.distance,
        isFavorite: entity.isFavorite);
  }

  static PointEntity mapToEntity(Point point) {
    return PointEntity(
      point.id,
      point.name,
      point.location.lat,
      point.location.lng,
      point.address,
      point.distance,
      point.isFavorite,
    );
  }
}
