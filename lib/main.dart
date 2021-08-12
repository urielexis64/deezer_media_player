import 'package:deezer_media_player/db/app_theme.dart';
import 'package:deezer_media_player/db/db.dart';
import 'package:deezer_media_player/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await MyAppTheme.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAppTheme.instance,
      child: Consumer<MyAppTheme>(
        builder: (_, __, ___) {
          return MaterialApp(
            title: 'Deezer Media Player',
            theme: MyAppTheme.instance.theme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
