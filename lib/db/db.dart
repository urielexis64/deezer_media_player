import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  DB._();
  static DB _instance = DB._();
  static DB get instance => _instance;

  late Database _database;

  Database get database => _database;

  Future<void> init() async {
    final String dbName = "flutter_rocks.db";
    final path = (await getApplicationDocumentsDirectory()).path;
    final dbPath = join(path, dbName);

    _database = await databaseFactoryIo.openDatabase(dbPath);
  }
}
