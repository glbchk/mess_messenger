import 'package:flutter/material.dart';

enum Palette {
  powderBlue(Color(0xFFD2E3F7)),
  lavenderBlush(Color(0xFFF7E8FA)),
  dustyRose(Color(0xFFEAD2D7)),
  paleMauve(Color(0xFFEAD7D5)),
  peach(Color(0xFFE7C4A9)),
  pastelYellow(Color(0xFFEAE39E)),
  cream(Color(0xFFFAF2DC)),
  paleLime(Color(0xFFDFE89D)),
  mintGreen(Color(0xFF9DE0AD)),
  teaGreen(Color(0xFFCBE7CE)),
  paleTeal(Color(0xFFD0E5DF)),
  lightCyan(Color(0xFFD0E9E8)),
  skyBlue(Color(0xFF9CD5E4)),
  thistle(Color(0xFFE6CAD6)),
  orchid(Color(0xFFDEA6DF)),
  palePink(Color(0xFFFCE6F2)),
  periwinkle(Color(0xFFB1A2E0)),
  lavenderBlue(Color(0xFFCBCBEB)),
  paleAqua(Color(0xFFCCE8E7)),
  sageGreen(Color(0xFFCCE4D5));

  final Color color;
  const Palette(this.color);

  static Palette fromName(String? name) =>
      values.firstWhere((p) => p.name == name, orElse: () => values.first);
}
