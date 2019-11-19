import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workshop/domain/model/point.dart';
import 'package:flutter_workshop/domain/repository/point_repository.dart';
import 'package:flutter_workshop/presentation/home/home_bloc.dart';
import 'package:flutter_workshop/presentation/home/home_event.dart';
import 'package:flutter_workshop/presentation/home/home_state.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    final PointRepository pointRepository = Provider.of(context);
    return BlocProvider(
      builder: (_) => HomeBloc(pointRepository)..add(FetchPoints()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Home'),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is Content) {
          final items = state.points;
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildPointItem(context, item);
              });
        }
      },
    );
  }

  Widget _buildPointItem(BuildContext context, Point point) {
    return Column(
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
    );
  }
}
