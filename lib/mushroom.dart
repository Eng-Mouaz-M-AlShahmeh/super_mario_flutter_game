/* Developed By Eng Mouaz M. AlShahmeh */
import 'package:flutter/material.dart';

class IMushroom extends StatelessWidget {
  const IMushroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: Image.asset('lib/images/mushroom.png'),
    );
  }
}
