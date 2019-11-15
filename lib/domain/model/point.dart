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

  Point(this.id, this.name, this.location, this.address);
}
