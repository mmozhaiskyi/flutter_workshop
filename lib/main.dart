import 'package:flutter/material.dart';
import 'package:flutter_workshop/di/providers.dart';
import 'package:flutter_workshop/presentation/home/home_widget.dart';
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
        routes: {
          HomeWidget.route: (_) => HomeWidget()
        },
      ),
    );
  }
}
