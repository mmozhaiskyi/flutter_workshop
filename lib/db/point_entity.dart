import 'package:floor/floor.dart';

@entity
class PointEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;

  final String name;
  final double lat;
  final double long;
  final String address;
  final int distance;
  final bool isFavorite;

  PointEntity(
    this.id,
    this.name,
    this.lat,
    this.long,
    this.address,
    this.distance,
    this.isFavorite,
  );
}
