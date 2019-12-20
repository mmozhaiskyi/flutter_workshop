import 'package:floor/floor.dart';
import 'package:flutter_workshop/db/point_dao.dart';
import 'package:flutter_workshop/db/point_entity.dart';

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [PointEntity])
abstract class AppDatabase extends FloorDatabase {

  PointDao get pointDao;
}