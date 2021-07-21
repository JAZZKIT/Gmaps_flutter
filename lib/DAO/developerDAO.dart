import 'package:floor/floor.dart';
import 'package:gmaps_practice/entity/developer.dart';

@dao
abstract class DeveloperDAO {
  @Query('SELECT * FROM Developer')
  Stream<List<Developer?>> getAllDeveloper();

  @Query('SELECT * FROM Developer WHERE id = :id')
  Stream<Developer?> getAllDeveloperById(int id);

  @Query('DELETE FROM Developer')
  Future<void> deleteAllDeveloper();

  @insert
  Future<void> insertDeveloper(Developer? developer);

  @update
  Future<void> updateDeveloper(Developer? developer);

  @delete
  Future<void> deleteDeveloper(Developer? developer);
}
