import 'package:deezer_media_player/flutter_inner_drawer.dart';
import 'package:deezer_media_player/pages/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<InnerDrawerState> _drawerStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _drawerStateKey,
      onTapClose: true,
      rightChild: Container(
        color: Colors.white,
      ),
      scaffold: Scaffold(
        body: CustomScrollView(
          slivers: [
            HomeHeader(drawerKey: _drawerStateKey),
          ],
        ),
      ),
    );
  }
}
