/* Developed By Eng Mouaz M. AlShahmeh */
import 'dart:math';
import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  const JumpingMario({Key? key, this.direction, this.size}) : super(key: key);

  final String? direction;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return SizedBox(
        width: size,
        height: size,
        child: Image.asset('lib/images/jumpingMario.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          width: size,
          height: size,
          child: Image.asset('lib/images/jumpingMario.png'),
        ),
      );
    }
  }
}
