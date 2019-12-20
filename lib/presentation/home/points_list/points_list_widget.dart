import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workshop/db/database_container.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/presentation/home/home_event.dart';
import 'package:flutter_workshop/presentation/home/points_list/points_bloc.dart';
import 'package:flutter_workshop/presentation/home/points_list/points_event.dart';
import 'package:flutter_workshop/presentation/home/points_list/points_state.dart';
import 'package:flutter_workshop/presentation/point_details/point_details_widget.dart';
import 'package:provider/provider.dart';

class PointsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DatabaseContainer dbContainer = Provider.of(context);
    return BlocProvider(
      builder: (_) => PointsBloc(dbContainer),
      child: BlocBuilder<PointsBloc, PointsState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Points) {
            return ListView.builder(
                itemCount: state.points.length,
                itemBuilder: (context, index) {
                  final point = state.points[index];
                  return _buildPointItem(context, point);
                });
          } else
            return Container();
        },
      ),
    );
  }

  Widget _buildPointItem(BuildContext context, Point point) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(PointDetailsWidget.route, arguments: point),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  point.name ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 16,
                    ),
                    Text(
                      point.address ?? 'Unknown',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
            IconButton(
              icon: Icon(_getFavoriteIcon(point)),
              onPressed: () {
                point.isFavorite = !point.isFavorite;
                BlocProvider.of<PointsBloc>(context)
                    .add(PointFavSelected(point));
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFavoriteIcon(Point point) {
    if (point.isFavorite)
      return Icons.star;
    else
      return Icons.star_border;
  }
}
