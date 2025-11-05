import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../core/constants/app_constants.dart';
import '../models/movie_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppConstants.databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT';
    const integerType = 'INTEGER';
    const realType = 'REAL';

    // Movies table
    await db.execute('''
      CREATE TABLE ${AppConstants.moviesTable} (
        id $idType,
        title $textType NOT NULL,
        poster_path $textType,
        backdrop_path $textType,
        overview $textType NOT NULL,
        release_date $textType,
        vote_average $realType NOT NULL,
        vote_count $integerType NOT NULL,
        popularity $realType NOT NULL,
        genre_ids $textType,
        original_language $textType,
        adult $integerType NOT NULL,
        original_title $textType,
        category $textType NOT NULL,
        created_at $textType NOT NULL
      )
    ''');

    // Bookmarks table
    await db.execute('''
      CREATE TABLE ${AppConstants.bookmarksTable} (
        id $idType,
        movie_id $integerType NOT NULL UNIQUE,
        created_at $textType NOT NULL
      )
    ''');
  }

  // Movies CRUD operations
  Future<int> insertMovie(MovieModel movie, String category) async {
    final db = await database;
    final map = movie.toMap();
    map['category'] = category;
    map['created_at'] = DateTime.now().toIso8601String();

    return await db.insert(
      AppConstants.moviesTable,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MovieModel>> getMoviesByCategory(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.moviesTable,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) => MovieModel.fromMap(maps[i]));
  }

  Future<MovieModel?> getMovieById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.moviesTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return MovieModel.fromMap(maps[0]);
  }

  Future<int> deleteMoviesByCategory(String category) async {
    final db = await database;
    return await db.delete(
      AppConstants.moviesTable,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  // Bookmarks CRUD operations
  Future<int> addBookmark(int movieId) async {
    final db = await database;
    return await db.insert(
      AppConstants.bookmarksTable,
      {
        'movie_id': movieId,
        'created_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeBookmark(int movieId) async {
    final db = await database;
    return await db.delete(
      AppConstants.bookmarksTable,
      where: 'movie_id = ?',
      whereArgs: [movieId],
    );
  }

  Future<bool> isBookmarked(int movieId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.bookmarksTable,
      where: 'movie_id = ?',
      whereArgs: [movieId],
      limit: 1,
    );

    return maps.isNotEmpty;
  }

  Future<List<int>> getAllBookmarkedMovieIds() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.bookmarksTable,
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) => maps[i]['movie_id'] as int);
  }

  Future<List<MovieModel>> getBookmarkedMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT m.* FROM ${AppConstants.moviesTable} m
      INNER JOIN ${AppConstants.bookmarksTable} b ON m.id = b.movie_id
      ORDER BY b.created_at DESC
    ''');

    return List.generate(maps.length, (i) => MovieModel.fromMap(maps[i]));
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
