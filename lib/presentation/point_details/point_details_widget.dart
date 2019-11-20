import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/domain/model/point.dart';

class PointDetailsWidget extends StatelessWidget {
  static const route = '/point_details';

  final Point _point;

  const PointDetailsWidget(this._point);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(_point.name),
    );
  }
}
