import 'package:deezer_media_player/pages/home/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deezer Media Player',
      home: HomePage(),
    );
  }
}
