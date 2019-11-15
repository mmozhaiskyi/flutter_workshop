import 'package:bloc/bloc.dart';
import 'package:flutter_workshop/domain/model/point.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  @override
  HomeState get initialState => Loading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchPoints) {
      final points = _dataSource();
      yield Content(points);
    }
  }

  List<Point> _dataSource() {
    return <Point>[
      Point('1', 'Café de Fleurs', Location(50.3945155, 30.473572), 'Holosiivskyi prospekt, 110, Kyiv, Ukraine, 03127'),
      Point('2', 'B&A Cafe', Location(50.3945676, 30.473572), 'Vasylkivska St, 14, Kyiv, Ukraine, 02000'),
      Point('3', 'Dacha', Location(50.3945676, 30.473572), 'Mykhaila Lomonosova St, 71Г, Kyiv, Ukraine, 03189')
    ];
  }
}
