import 'package:deezer_media_player/db/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

class MyAppTheme extends ChangeNotifier {
  MyAppTheme._();
  static MyAppTheme _instance = MyAppTheme._();
  static MyAppTheme get instance => _instance;

  final StoreRef _storeRef = StoreRef.main();

  final Database _db = DB.instance.database;

  late bool _darkEnabled;

  bool get darkEnabled => _darkEnabled;

  Future<void> init() async {
    _darkEnabled = (await _storeRef.record('darkEnabled').get(_db)) ?? false;
  }

  Future<void> setTheme(bool isDarkEnabled) async {
    await _storeRef.record('darkEnabled').put(_db, isDarkEnabled);
    _darkEnabled = isDarkEnabled;
    notifyListeners();
  }

  ThemeData get theme => _darkEnabled
      ? ThemeData(
          scaffoldBackgroundColor: Color(0xff102027),
          fontFamily: 'sans',
          brightness: Brightness.dark)
      : ThemeData();
}
