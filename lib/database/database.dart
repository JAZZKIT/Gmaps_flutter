import 'package:floor/floor.dart';
import 'package:gmaps_practice/DAO/developerDAO.dart';
import 'package:gmaps_practice/entity/developer.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Developer])
abstract class AppDataBase extends FloorDatabase {
  DeveloperDAO get developerDAO;
}
