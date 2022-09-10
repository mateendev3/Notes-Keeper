import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';
import '../utils/db_constants.dart';

class DBHelper {
  DBHelper._init();

  static DBHelper? _dbHelper;
  Database? _database;

  factory DBHelper() {
    return _dbHelper ??= DBHelper._init();
  }

  Future<Database> _getDB() async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String dbFilePath = path.join(databasePath, DBConsts.dbName);
    return await openDatabase(
      dbFilePath,
      version: DBConsts.dbVersion,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute(DBConsts.createTableCommand);
  }

  Future<void> closeDatabase() async {
    final Database db = await _getDB();
    await db.close();
  }

  /// CRUD OPERATIONS

  // insert note to db
  Future<Note> insertNote(Note note) async {
    final Database db = await _getDB();

    int id = await db.insert(DBConsts.tableName, note.toMap());
    return id > 0
        ? note.copyWith(id: id)
        : throw Exception('Data insertion failed.');
  }

  // read note from db
  Future<Note> readNote(int id) async {
    final Database db = await _getDB();

    List<Map<String, Object?>> queryList = await db.query(
      DBConsts.tableName,
      columns: DBConsts.columNames,
      where: '${DBConsts.colId} = ?',
      whereArgs: [id],
    );

    if (queryList.isNotEmpty) {
      return Note.fromMap(queryList.first);
    }

    throw Exception('ID $id not found');
  }

  // read all notes from db
  Future<List<Note>> readAllNotes() async {
    final Database db = await _getDB();

    List<Map<String, Object?>> queryList = await db.query(
      DBConsts.tableName,
      orderBy: DBConsts.orderByTime,
    );

    return queryList.map((map) => Note.fromMap(map)).toList();
  }

  // update note
  Future<bool> updateNote(Note note) async {
    final Database db = await _getDB();

    int changesMade = await db.update(
      DBConsts.tableName,
      note.toMap(),
      where: '${DBConsts.colId} = ?',
      whereArgs: [note.id],
    );

    return changesMade > 0;
  }

  // delete note
  Future<bool> deleteNote(int id) async {
    final Database db = await _getDB();

    int rowsEffected = await db.delete(
      DBConsts.tableName,
      where: '${DBConsts.colId} = ?',
      whereArgs: [id],
    );

    return rowsEffected > 0;
  }

  // delete all notes
  Future<bool> deleteNotes() async {
    final Database db = await _getDB();

    int changesMade = await db.rawDelete(DBConsts.deleteEverythingCommand);
    return changesMade > 0;
  }
}
