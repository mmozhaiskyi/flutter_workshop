import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workshop/db/database_container.dart';
import 'package:flutter_workshop/domain/repository/point_repository.dart';
import 'package:flutter_workshop/domain/util/location_provider.dart';
import 'package:flutter_workshop/presentation/home/home_bloc.dart';
import 'package:flutter_workshop/presentation/home/home_event.dart';
import 'package:flutter_workshop/presentation/home/home_state.dart';
import 'package:flutter_workshop/presentation/home/map_widget.dart';
import 'package:flutter_workshop/presentation/home/points_list/points_list_widget.dart';
import 'package:provider/provider.dart';

enum _HomeType { list, map }

class HomeWidget extends StatefulWidget {
  static const route = '/';

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeWidget> {
  var _type = _HomeType.map;

  @override
  Widget build(BuildContext context) {
    final PointRepository pointRepository = Provider.of(context);
    final LocationProvider locationProvider = Provider.of(context);
    final DatabaseContainer dbContainer = Provider.of(context);
    return BlocProvider(
      builder: (_) => HomeBloc(pointRepository, locationProvider, dbContainer)
        ..add(FetchPoints()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Home'),
      actions: <Widget>[
        Switch(
            value: _type == _HomeType.map ? true : false,
            onChanged: (value) {
              final type = value ? _HomeType.map : _HomeType.list;
              setState(() {
                _type = type;
              });
            })
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is Content) {
          return IndexedStack(
            index: _type.index,
            children: <Widget>[
              PointsListWidget(),
              MapWidget(state.points, state.userLocation, state.searchAreaRadius),
            ],
          );
        }
      },
    );
  }
}
