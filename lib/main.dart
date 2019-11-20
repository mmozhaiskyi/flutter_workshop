import 'package:flutter/material.dart';
import 'package:flutter_workshop/di/providers.dart';
import 'package:flutter_workshop/presentation/home/home_widget.dart';
import 'package:flutter_workshop/presentation/point_details/point_details_widget.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeWidget.route,
        onGenerateRoute: (settings) {
          // ignore: missing_return
          final widget = () {
            switch (settings.name) {
              case HomeWidget.route: return HomeWidget();
              case PointDetailsWidget.route: {
                final point = settings.arguments;
                return PointDetailsWidget(point);
              }
            }
          };
          return MaterialPageRoute(builder: (_) => widget());
        },
      ),
    );
  }
}
