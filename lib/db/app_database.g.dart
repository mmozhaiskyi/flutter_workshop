// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PointDao _pointDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PointEntity` (`id` TEXT, `name` TEXT, `lat` REAL, `long` REAL, `address` TEXT, `distance` INTEGER, `isFavorite` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  PointDao get pointDao {
    return _pointDaoInstance ??= _$PointDao(database, changeListener);
  }
}

class _$PointDao extends PointDao {
  _$PointDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _pointEntityInsertionAdapter = InsertionAdapter(
            database,
            'PointEntity',
            (PointEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'lat': item.lat,
                  'long': item.long,
                  'address': item.address,
                  'distance': item.distance,
                  'isFavorite': item.isFavorite ? 1 : 0
                },
            changeListener),
        _pointEntityUpdateAdapter = UpdateAdapter(
            database,
            'PointEntity',
            ['id'],
            (PointEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'lat': item.lat,
                  'long': item.long,
                  'address': item.address,
                  'distance': item.distance,
                  'isFavorite': item.isFavorite ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _pointEntityMapper = (Map<String, dynamic> row) => PointEntity(
      row['id'] as String,
      row['name'] as String,
      row['lat'] as double,
      row['long'] as double,
      row['address'] as String,
      row['distance'] as int,
      (row['isFavorite'] as int) != 0);

  final InsertionAdapter<PointEntity> _pointEntityInsertionAdapter;

  final UpdateAdapter<PointEntity> _pointEntityUpdateAdapter;

  @override
  Stream<List<PointEntity>> observePoints() {
    return _queryAdapter.queryListStream('SELECT * FROM PointEntity',
        tableName: 'PointEntity', mapper: _pointEntityMapper);
  }

  @override
  Future<void> insert(List<PointEntity> points) async {
    await _pointEntityInsertionAdapter.insertList(
        points, sqflite.ConflictAlgorithm.ignore);
  }

  @override
  Future<void> update(PointEntity entity) async {
    await _pointEntityUpdateAdapter.update(
        entity, sqflite.ConflictAlgorithm.abort);
  }
}
