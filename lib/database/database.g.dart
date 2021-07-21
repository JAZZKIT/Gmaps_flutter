// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DeveloperDAO? _developerDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Developer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `firstName` TEXT, `lastName` TEXT, `email` TEXT, `jobTitle` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DeveloperDAO get developerDAO {
    return _developerDAOInstance ??= _$DeveloperDAO(database, changeListener);
  }
}

class _$DeveloperDAO extends DeveloperDAO {
  _$DeveloperDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _developerInsertionAdapter = InsertionAdapter(
            database,
            'Developer',
            (Developer item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'email': item.email,
                  'jobTitle': item.jobTitle
                },
            changeListener),
        _developerUpdateAdapter = UpdateAdapter(
            database,
            'Developer',
            ['id'],
            (Developer item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'email': item.email,
                  'jobTitle': item.jobTitle
                },
            changeListener),
        _developerDeletionAdapter = DeletionAdapter(
            database,
            'Developer',
            ['id'],
            (Developer item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'email': item.email,
                  'jobTitle': item.jobTitle
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Developer> _developerInsertionAdapter;

  final UpdateAdapter<Developer> _developerUpdateAdapter;

  final DeletionAdapter<Developer> _developerDeletionAdapter;

  @override
  Stream<List<Developer?>> getAllDeveloper() {
    return _queryAdapter.queryListStream('SELECT * FROM Developer',
        mapper: (Map<String, Object?> row) => Developer(
            id: row['id'] as int?,
            firstName: row['firstName'] as String?,
            lastName: row['lastName'] as String?,
            email: row['email'] as String?,
            jobTitle: row['jobTitle'] as String?),
        queryableName: 'Developer',
        isView: false);
  }

  @override
  Stream<Developer?> getAllDeveloperById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Developer WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Developer(
            id: row['id'] as int?,
            firstName: row['firstName'] as String?,
            lastName: row['lastName'] as String?,
            email: row['email'] as String?,
            jobTitle: row['jobTitle'] as String?),
        arguments: [id],
        queryableName: 'Developer',
        isView: false);
  }

  @override
  Future<void> deleteAllDeveloper() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Developer');
  }

  @override
  Future<void> insertDeveloper(Developer? developer) async {
    await _developerInsertionAdapter.insert(
        developer!, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDeveloper(Developer? developer) async {
    await _developerUpdateAdapter.update(developer!, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDeveloper(Developer? developer) async {
    await _developerDeletionAdapter.delete(developer!);
  }
}
