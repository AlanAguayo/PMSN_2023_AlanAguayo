import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practicauno/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/event_model.dart';

class DatabaseHelper {
  static final nombreBD = "TECBOOKBD";
  static final versionBD = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nombreBD);
    //await deleteDatabase(
    //    pathDB); //Usar en caso de que no se pueda acceder a la bd
    return await openDatabase(
      pathDB,
      version: versionBD,
      onCreate: _createTable,
    );
  }

  _createTable(Database db, int version) {
    String query =
        "CREATE TABLE tblPost(idPost INTEGER PRIMARY KEY, dscPost VARCHAR(200), datePost DATE)  ";
    db.execute(query);
    query =
        "CREATE TABLE tblEvent(idEvento INTEGER PRIMARY KEY, dscEvento VARCHAR(100), fechaEvento DATE, completado TINYINT) ";
    db.execute(query);
  }

  Future<int> INSERTAR(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion.insert(table, map);
  }

  Future<int> ACTUALIZAR(String table, Map<String, dynamic> map, id) async {
    var conexion = await database;
    return await conexion
        .update(table, map, where: '$id = ?', whereArgs: [map[id]]);
  }

  Future<int> ELIMINAR(String table, int id, String idR) async {
    var conexion = await database;
    return await conexion.delete(table, where: '$idR = ?', whereArgs: [id]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost', orderBy: 'idPost DESC');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventModel>> GETALLEVENT() async {
    var conexion = await database;
    var result = await conexion.query('tblEvent', orderBy: 'fechaEvento ASC');
    return result.map((event) => EventModel.fromMap(event)).toList();
  }

  Future<List<EventModel>> GETDAYEVENT(DateTime day) async {
    var conexion = await database;
    var result = await conexion.query('tblEvent',
        orderBy: 'fechaEvento ASC',
        where: 'fechaEvento = "${DateFormat('yyyy-MM-dd').format(day)}"');
    return result.map((event) => EventModel.fromMap(event)).toList();
  }
}
