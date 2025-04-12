import 'package:flutter/widgets.dart';

abstract class AppSpacing {
  static const double spaceUnit = 16;
  static const double xs = 0.375 * spaceUnit;
  static const double sm = 0.5 * spaceUnit;
  static const double md = 0.75 * spaceUnit;
  static const double lg = spaceUnit;

  static const EdgeInsets horizontalPaddingLg =
      EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets horizontalPaddingSm =
      EdgeInsets.symmetric(horizontal: sm);

  static const SizedBox verticalSpacerSm = SizedBox(
    height: sm,
  );
}
