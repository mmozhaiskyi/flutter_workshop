import 'package:bloc/bloc.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/domain/repository/point_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PointRepository _pointRepository;

  HomeBloc(this._pointRepository);

  @override
  HomeState get initialState => Loading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchPoints) {
      final points = await _pointRepository.getNearbyPoints(Location(40.7243, -74.0018), 'coffe');
      yield Content(points);
    }
  }
}
