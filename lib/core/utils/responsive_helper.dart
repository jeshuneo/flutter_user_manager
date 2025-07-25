import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static T getValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  static EdgeInsets getPadding(BuildContext context) {
    return EdgeInsets.all(
      getValue(context, mobile: 16.0, tablet: 24.0, desktop: 32.0),
    );
  }

  static int getCrossAxisCount(BuildContext context) {
    return getValue(context, mobile: 1, tablet: 2, desktop: 3);
  }
}
