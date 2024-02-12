import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget Small;
  final Widget Medium;
  final Widget Large;

  const Responsive({
    required this.Small,
    required this.Medium,
    required this.Large,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isMedium(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 650;

  static bool isLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return Large;
        }
        // If width it less then 1100 and more then 650 we consider it as screen_tablet
        else if (constraints.maxWidth >= 650) {
          return Medium;
        }
        // Or less then that we called it screen_mobile
        else {
          return Small;
        }
      },
    );
  }
}