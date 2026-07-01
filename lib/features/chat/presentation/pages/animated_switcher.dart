import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget animatedSvgSwitcher({
  required bool selected,
  required String firstSvg,
  required String secondSvg,
  required VoidCallback onPressed,
}) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (child, animation) {
      return FadeTransition(
        opacity: animation,
        child: RotationTransition(
          turns: Tween<double>(begin: 0.25, end: 0).animate(animation),
          child: child,
        ),
      );
    },
    child: GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        height: 28,
        selected ? secondSvg : firstSvg,
        key: ValueKey(selected),
      ),
    ),
  );
}
