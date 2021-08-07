import 'package:deezer_media_player/flutter_inner_drawer.dart';
import 'package:deezer_media_player/pages/home/widgets/bird.dart';
import 'package:deezer_media_player/pages/home/widgets/my_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                ClipPath(
                  clipper: _MyCustomClipper(),
                  child: Container(
                    color: Color(0xff01579b),
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      'assets/pages/home/happy.svg',
                      width: constraints.maxWidth * .55,
                    )),
                Positioned(
                    right: constraints.maxWidth * .163,
                    bottom: constraints.maxHeight * .1,
                    child: Bird(size: constraints.maxWidth * .22)),
                Positioned(
                    right: 10,
                    top: 10,
                    child: SafeArea(
                      child: MyAvatar(
                        onPressed: () {
                          drawerKey.currentState!.open();
                        },
                      ),
                    )),
              ],
            );
          })),
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
