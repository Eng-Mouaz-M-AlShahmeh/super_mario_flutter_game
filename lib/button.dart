/* Developed By Eng Mouaz M. AlShahmeh */
import 'package:flutter/material.dart';

class IButton extends StatelessWidget {
  const IButton({Key? key, this.child, this.function}) : super(key: key);

  final Widget? child;
  final Function()? function;
  static bool holdingButton = false;

  bool userIsHoldingButton() {
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        holdingButton = true;
        function!();
      },
      onTapUp: (details) {
        holdingButton = false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.brown[300],
          child: child,
        ),
      ),
    );
  }
}
