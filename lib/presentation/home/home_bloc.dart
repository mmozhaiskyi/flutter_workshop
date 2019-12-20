import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_workshop/db/database_container.dart';
import 'package:flutter_workshop/db/point_entity.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/domain/repository/point_repository.dart';
import 'package:flutter_workshop/domain/util/location_provider.dart';
import 'package:flutter_workshop/mappers/points_mapper.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PointRepository _pointRepository;
  final LocationProvider _locationProvider;
  final DatabaseContainer _databaseContainer;

  HomeBloc(
      this._pointRepository, this._locationProvider, this._databaseContainer);

  StreamSubscription _locationSubscription;

  @override
  HomeState get initialState => Loading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchPoints) {
      _observeLocation();
    } else if (event is LocationChanged) {
      final userLocation = event.location;
      final searchAreaRadius = 5000;
      final points = await _pointRepository.getNearbyPoints(
          userLocation, 'coffe', searchAreaRadius);
      if (state is Loading) await _addPoints(points);
      yield Content(points, userLocation, searchAreaRadius);
    }
  }

  @override
  Future<Function> close() {
    _locationSubscription?.cancel();
    return super.close();
  }

  Future _addPoints(List<Point> points) async {
    final db = await _databaseContainer.consume();
    final List<PointEntity> entities =
        points.map((point) => PointsMapper.mapToEntity(point)).toList();
    await db.pointDao.insert(entities);
  }

  void _observeLocation() {
    _locationSubscription = _locationProvider.observe().listen((location) {
      add(LocationChanged(location));
    });
  }
}
