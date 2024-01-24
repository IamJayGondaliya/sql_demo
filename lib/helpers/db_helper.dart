import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_demo/modals/hotel_modal.dart';

class DbHelper {
  DbHelper._() {
    initDb();
  }
  static final DbHelper dbHelper = DbHelper._();

  late Database database;

  Logger logger = Logger();

  String sql = "";

  String tableName = "Hotel";
  String colId = "id";
  String colName = "name";
  String colStars = "star";

  //initDB
  Future<void> initDb() async {
    String dbPath = await getDatabasesPath();
    String dbName = "my_db_1.db";
    String path = join(dbPath, dbName);

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        sql =
            "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT,$colStars REAL)";
        db
            .execute(sql)
            .then((value) => logger.i("Table created..."))
            .onError((error, stackTrace) => logger.e("ERROR: $error"));
      },
    );
  }

  //InsertRecord
  Future<int> insertRecord({required Hotel hotel}) async {
    await initDb();
    Map<String, dynamic> data = hotel.toMap;
    data.remove('id');
    return database.insert(tableName, data);
  }

  //SelectRecord
  Future<List<Hotel>> getRecords() async {
    await initDb();
    sql = "SELECT * FROM $tableName";

    List allData = await database.rawQuery(sql);

    return allData
        .map(
          (e) => Hotel.fromSQL(data: e),
        )
        .toList();
  }

  //DeleteRecord.
  Future<int> deleteRecord({required int id}) async {
    await initDb();

    return database.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //UpdateRecord
  Future<int> updateRecord({required Hotel hotel}) async {
    await initDb();
    sql =
        "UPDATE $tableName SET name='${hotel.name}',star=${hotel.star} WHERE id=${hotel.id}";
    return database.rawUpdate(sql);
    // return database.update(tableName, hotel.toMap);
  }
}
