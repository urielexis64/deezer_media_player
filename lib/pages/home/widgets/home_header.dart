import 'package:deezer_media_player/flutter_inner_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  HomeHeader({
    Key? key,
    required this.drawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
          aspectRatio: 16 / 11,
          child: Stack(
            children: [
              ClipPath(
                clipper: _MyCustomClipper(),
                child: Container(
                  color: Color(0xff01579b),
                ),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child: SafeArea(
                    child: CupertinoButton(
                      onPressed: () {
                        drawerKey.currentState!.open();
                      },
                      padding: EdgeInsets.zero,
                      child: CircleAvatar(
                        backgroundColor: Color(0xfff50057),
                        child: Text(
                          'UA',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        radius: 30,
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * .9);
    Offset arc1 = Offset(size.width, size.height / 2);
    path.arcToPoint(arc1,
        radius: Radius.circular(size.width), clockwise: false);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
