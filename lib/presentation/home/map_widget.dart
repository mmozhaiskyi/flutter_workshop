import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/presentation/point_details/point_details_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final List<Point> points;
  final Location initPosition;
  final int searchAreaRadius;

  const MapWidget(this.points, this.initPosition, this.searchAreaRadius);

  @override
  State<StatefulWidget> createState() => _MapState(points, initPosition, searchAreaRadius);
}

class _MapState extends State<MapWidget> {
  final List<Point> points;
  final Location initPosition;
  final int searchAreaRadius;

  Point _selectedPoint;

  _MapState(this.points, this.initPosition, this.searchAreaRadius);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildMap(context, searchAreaRadius),
        if (_selectedPoint != null) _buildDetailsCard(context, _selectedPoint),
      ],
    );
  }


  Widget _buildMap(BuildContext context, int searchAreaRadius) {
    final initCameraPosition = CameraPosition(
        target: LatLng(initPosition.lat, initPosition.lng),
        zoom: 11
    );
    return GoogleMap(
      initialCameraPosition: initCameraPosition,
      markers: _createMarkers(context),
      circles: {_buildSearchRadiusCircle(searchAreaRadius)},
      onTap: (_) {
        setState(() {
          _selectedPoint = null;
        });
      },
    );
  }

  Circle _buildSearchRadiusCircle(int searchAreaRadius) {
    return Circle(
      circleId: CircleId('search_area'),
      strokeColor: Colors.blue,
      strokeWidth: 3,
      radius: searchAreaRadius.toDouble(),
      center: LatLng(initPosition.lat, initPosition.lng)
    );
  }

  Widget _buildDetailsCard(BuildContext context, Point point) {
    final address = '${point?.address ?? 'Unknown'} (${point.distance} m)';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(PointDetailsWidget.route, arguments: point),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                            child: Text(point?.name ?? '', style: TextStyle(fontSize: 16),),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Center(child: Icon(Icons.location_on, color: Colors.grey, size: 16,)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 16, top: 16, bottom: 16),
                                child: Text(
                                  address, style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Set<Marker> _createMarkers(BuildContext context) {
    final markers = <Marker>[];
    for (var point in points) {
      final marker = Marker(
          markerId: MarkerId(point.name),
          infoWindow: InfoWindow(title: point.name),
          position: LatLng(point.location.lat, point.location.lng),
          onTap: () {
            setState(() {
              _selectedPoint = point;
            });
          }
      );
      markers.add(marker);
    }
    return markers.toSet();
  }
}
