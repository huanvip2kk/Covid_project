import 'package:covid_19/presentation/favorited/favorited_model/favorited_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // for join

class FavoritedDatabaseHelper {
  static const String favoritedTable = "FAVORITED";
  static const String id = "ID";
  static const String userName = "USER_NAME";
  static const String flag = "FLAG";
  static const String favoritedName = "COUNTRY_NAME";
  Database? _database;

  Future openDb() async {
    _database ??= await openDatabase(
        join(await getDatabasesPath(), "favoritedDatabase.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE $favoritedTable($id INTEGER PRIMARY KEY autoincrement,$userName TEXT,"
        "$flag TEXT,$favoritedName TEXT)",
      );
    });
  }

  ///Dong [_database] neu [_database] dang mo
  Future closeDb() async {
    if (_database!.isOpen) {
      _database!.close();
    }
  }

  Future<int> insertFavorited(FavoritedModel favoritedModel) async {
    await openDb();
    return await _database!.insert(favoritedTable, favoritedModel.toMap());
  }

  Future<int> deleteFavoritedByNameAndCountry(
      String name, String countryName) async {
    await openDb();
    var result = await _database!.delete(
      favoritedTable,
      where: "$userName =? and $favoritedName =?",
      whereArgs: [name, countryName],
    );

    return result;
  }

  Future<List<FavoritedModel>> getFavoritedByUsername(String name) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!
        .query(favoritedTable, where: "$userName=?", whereArgs: [name]);
    return List.generate(maps.length, (i) {
      return FavoritedModel(
        userName: maps[i][userName] as String,
        flag: maps[i][flag] as String,
        countryName: maps[i][favoritedName] as String,
      );
    });
  }

  Future<List<FavoritedModel>> getFavoritedByUsernameAndCountry(
      String name, String coutry) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query(
        favoritedTable,
        where: "$userName=? and $favoritedName=?",
        whereArgs: [name, coutry]);
    return List.generate(maps.length, (i) {
      return FavoritedModel(
        userName: maps[i][userName] as String,
        flag: maps[i][flag] as String,
        countryName: maps[i][favoritedName] as String,
      );
    });
  }

  Future<void> deleteAll() async {
    await openDb();
    await _database!.delete(favoritedTable);
  }
}
