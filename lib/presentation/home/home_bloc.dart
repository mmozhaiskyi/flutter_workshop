import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_workshop/domain/repository/point_repository.dart';
import 'package:flutter_workshop/domain/util/location_provider.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PointRepository _pointRepository;
  final LocationProvider _locationProvider;

  HomeBloc(this._pointRepository, this._locationProvider);

  StreamSubscription _locationSubscribtion;

  @override
  HomeState get initialState => Loading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchPoints) {
      _observeLocation();
    } else if (event is LocationChanged) {
      final userLocation = event.location;
      final searchAreaRadius = 5000;
      final points = await _pointRepository.getNearbyPoints(userLocation, 'coffe', searchAreaRadius);
      yield Content(points, userLocation, searchAreaRadius);
    }
  }


  @override
  Future<Function> close() {
    _locationSubscribtion?.cancel();
    super.close();
  }

  void _observeLocation() {
    _locationSubscribtion = _locationProvider.observe().listen((location) {
      add(LocationChanged(location));
    });
  }
}
