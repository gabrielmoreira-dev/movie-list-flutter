import 'package:movie_list/model/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  final movieTable = "movie";
  final idField = "id";
  final titleField = "title";
  final rateField = "rate";
  final yearField = "year";
  final studioField = "studio";

  static final _dbHelper = DBHelper._internal();
  static Database? _db;

  DBHelper._internal();

  factory DBHelper() => _dbHelper;

  Future<Database> get db async {
    _db ??= await initializeDB();
    return _db!;
  }

  Future<Database> initializeDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}movies.db";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int newVersion) async => await db.execute(
        """CREATE TABLE $movieTable(
          $idField INTEGER PRIMARY KEY,
          $titleField TEXT,
          $rateField INTEGER,
          $yearField INTEGER,
          $studioField TEXT
        )""",
      );

  Future<int> insertMovie(Movie movie) async {
    final db = await this.db;
    return await db.insert(movieTable, movie.toMap());
  }

  Future<List> getMovies() async {
    final db = await this.db;
    return await db
        .rawQuery("SELECT * FROM $movieTable ORDER BY $rateField DESC, $titleField ASC");
  }

  Future<int> updateMovie(Movie movie) async {
    final db = await this.db;
    return await db.update(
      movieTable,
      movie.toMap(),
      where: "$idField = ?",
      whereArgs: [movie.id],
    );
  }

  Future<int> deleteMovie(int id) async {
    final db = await this.db;
    return await db.rawDelete("DELETE FROM $movieTable WHERE $idField = $id");
  }
}
