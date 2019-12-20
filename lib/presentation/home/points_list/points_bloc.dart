import 'dart:async';

import 'package:flutter_workshop/db/database_container.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/mappers/points_mapper.dart';
import 'package:flutter_workshop/presentation/home/points_list/points_event.dart';
import 'package:flutter_workshop/presentation/home/points_list/points_state.dart';
import 'package:bloc/bloc.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final DatabaseContainer _databaseContainer;

  PointsBloc(this._databaseContainer) {
    _observerPoints();
  }

  StreamSubscription<List<Point>> _pointsSubscription;

  @override
  PointsState get initialState => Loading();

  @override
  Stream<PointsState> mapEventToState(PointsEvent event) async* {
    if (event is PointsContent) {
      yield Points(event.points);
    } else if (event is PointFavSelected) {
      await _updatePoint(event.point);
    }
  }

  @override
  Future<void> close() {
    _pointsSubscription.cancel();
    return super.close();
  }

  void _observerPoints() async {
    final db = await _databaseContainer.consume();
    _pointsSubscription = db.pointDao.observePoints().map((entities) {
      return entities.map((entity) => PointsMapper.mapToPoint(entity)).toList();
    }).listen((points) {
      add(PointsContent(points));
    });
  }

  Future<void> _updatePoint(Point point) async {
    final db = await _databaseContainer.consume();
    final entity = PointsMapper.mapToEntity(point);
    await db.pointDao.update(entity);
  }
}
