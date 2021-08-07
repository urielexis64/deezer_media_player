import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bird extends StatefulWidget {
  final double size;

  Bird({required this.size});

  @override
  _BirdState createState() => _BirdState();
}

class _BirdState extends State<Bird> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _angleAnimation;

  double _degreesToRadians(double degrees) => degrees * math.pi / 180;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _angleAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween(begin: _degreesToRadians(3), end: _degreesToRadians(-3)),
          weight: 50),
      TweenSequenceItem<double>(
          tween: Tween(begin: _degreesToRadians(-3), end: _degreesToRadians(3)),
          weight: 50),
    ]).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _angleAnimation.value,
          child: child,
          origin: Offset(0, widget.size * .4),
        );
      },
      animation: _angleAnimation,
      child: SvgPicture.asset(
        'assets/pages/home/bird.svg',
        width: widget.size,
      ),
    );
  }
}
