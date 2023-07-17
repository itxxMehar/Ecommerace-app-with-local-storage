import 'dart:math';

import 'package:flutter/material.dart';

class SizeConfig {
  static double textScaleFactor(BuildContext context, double maxTextScaleFactor ) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1600) * maxTextScaleFactor;
    double val1 = (width / 600) * maxTextScaleFactor;
    return max(  val1,min(val, maxTextScaleFactor));
  }
}