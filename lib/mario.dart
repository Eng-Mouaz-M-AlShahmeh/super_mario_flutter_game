/* Developed By Eng Mouaz M. AlShahmeh */
import 'dart:math';
import 'package:flutter/material.dart';

class IMario extends StatelessWidget {
  const IMario({Key? key, this.direction, this.midRun, this.size})
      : super(key: key);

  final String? direction;
  final bool? midRun;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return SizedBox(
        width: size,
        height: size,
        child: midRun!
            ? Image.asset('lib/images/standingMario.png')
            : Image.asset('lib/images/runningMario.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          width: size,
          height: size,
          child: midRun!
              ? Image.asset('lib/images/standingMario.png')
              : Image.asset('lib/images/runningMario.png'),
        ),
      );
    }
  }
}
