class DBConsts {
  static const String dbName = 'notes.db';
  static const int dbVersion = 1;

  static const String tableName = 'NOTES';
  static const String colId = '_id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';
  static const String colTime = 'time';

  static const String _idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String _textType = 'TEXT NOT NULL';

  static const List<String> columNames = [
    colId,
    colTitle,
    colDescription,
    colTime,
  ];

  static const String orderByTime = '$colTime ASC';

  static const String createTableCommand = '''
CREATE TABLE $tableName (
  $colId $_idType,
  $colTitle $_textType,
  $colDescription $_textType,
  $colTime $_textType
)
''';

  static const String deleteEverythingCommand = 'DELETE FROM $tableName';
}
