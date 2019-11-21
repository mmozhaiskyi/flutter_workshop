import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/network/static_maps_service.dart';
import 'package:provider/provider.dart';

class PointDetailsWidget extends StatelessWidget {
  static const route = '/point_details';

  final Point _point;

  const PointDetailsWidget(this._point);

  @override
  Widget build(BuildContext context) {
    final StaticMapsService staticMapsService = Provider.of(context);
    return Scaffold(
      appBar: _buildAppBar(context, _point),
      body: Image.network(staticMapsService.path(_point)),
    );
  }

  Widget _buildAppBar(BuildContext context, Point point) {
    return AppBar(
      title: Text(point.name),
    );
  }
}
