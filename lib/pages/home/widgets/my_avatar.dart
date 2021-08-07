import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  final VoidCallback onPressed;

  const MyAvatar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: CircleAvatar(
        backgroundColor: Color(0xfff50057),
        child: Text(
          'UA',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white),
        ),
        radius: 30,
      ),
    );
  }
}
