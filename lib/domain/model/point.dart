class Location {
  final double lat;
  final double lng;

  Location(this.lat, this.lng);
}

class Point {
  final String id;
  final String name;
  final Location location;
  final String address;
  final int distance;
  bool isFavorite;

  Point(this.id, this.name, this.location, this.address, this.distance,
      {this.isFavorite = false});
}
