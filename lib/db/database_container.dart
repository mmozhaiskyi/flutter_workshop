import 'dart:async';
import 'package:flutter_workshop/db/app_database.dart';
import 'app_database.dart';

class DatabaseContainer {

  AppDatabase _database;

  FutureOr<AppDatabase> consume() async {
    if(_database == null) {
      _database = await await $FloorAppDatabase
          .databaseBuilder('app_database.db')
          .build();
    }
    return _database;
  }
}