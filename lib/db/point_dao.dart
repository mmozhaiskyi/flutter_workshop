import 'package:floor/floor.dart';
import 'package:flutter_workshop/db/point_entity.dart';

@dao
abstract class PointDao {

  @Insert(onConflict: OnConflictStrategy.IGNORE)
  Future<void> insert(List<PointEntity> points);

  @Update()
  Future<void> update(PointEntity entity);

  @Query('SELECT * FROM PointEntity')
  Stream<List<PointEntity>> observePoints();
}
