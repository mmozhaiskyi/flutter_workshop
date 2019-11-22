import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/presentation/point_details/point_details_widget.dart';

class PointsListWidget extends StatelessWidget {

  final List<Point> points;

  const PointsListWidget(this.points);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: points.length,
          itemBuilder: (context, index) {
            final point = points[index];
            return _buildPointItem(context, point);
          }),
    );
  }

  Widget _buildPointItem(BuildContext context, Point point) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(PointDetailsWidget.route, arguments: point),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(point.name ?? '', style: TextStyle(fontSize: 16),),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 8),
                child: Icon(Icons.location_on, color: Colors.grey, size: 16,),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 16, top: 8),
                  child: Text(
                    point.address ?? 'Unknown', style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
