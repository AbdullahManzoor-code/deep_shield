import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
  
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 1024;
  }
  
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  
  // Responsive padding
  static EdgeInsets getPadding(BuildContext context) {
    if (isDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 60, vertical: 30);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 25);
    } else {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    }
  }
  
  // Responsive font sizes
  static double getTitleFontSize(BuildContext context) {
    if (isDesktop(context)) return 28;
    if (isTablet(context)) return 24;
    return 20;
  }
  
  static double getSubtitleFontSize(BuildContext context) {
    if (isDesktop(context)) return 20;
    if (isTablet(context)) return 18;
    return 16;
  }
  
  static double getBodyFontSize(BuildContext context) {
    if (isDesktop(context)) return 18;
    if (isTablet(context)) return 16;
    return 14;
  }
  
  // Responsive button heights
  static double getButtonHeight(BuildContext context) {
    if (isDesktop(context)) return 65;
    if (isTablet(context)) return 60;
    return 50;
  }
  
  // Responsive icon sizes
  static double getIconSize(BuildContext context) {
    if (isDesktop(context)) return 36;
    if (isTablet(context)) return 32;
    return 24;
  }
  
  // Responsive logo sizes
  static double getLogoSize(BuildContext context) {
    if (isDesktop(context)) return 250;
    if (isTablet(context)) return 200;
    return 150;
  }
  
  // Max width constraints for content
  static double getMaxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 800;
    if (isTablet(context)) return 600;
    return double.infinity;
  }
  
  // Responsive spacing
  static double getSpacing(BuildContext context, {double multiplier = 1.0}) {
    double baseSpacing;
    if (isDesktop(context)) {
      baseSpacing = 30;
    } else if (isTablet(context)) {
      baseSpacing = 25;
    } else {
      baseSpacing = 20;
    }
    return baseSpacing * multiplier;
  }
  
  // Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
  
  // Get safe area insets
  static EdgeInsets getSafeAreaInsets(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
  
  // Responsive card padding
  static EdgeInsets getCardPadding(BuildContext context) {
    if (isDesktop(context)) {
      return const EdgeInsets.all(30);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(25);
    } else {
      return const EdgeInsets.all(20);
    }
  }
  
  // Responsive border radius
  static double getBorderRadius(BuildContext context) {
    if (isDesktop(context)) return 25;
    if (isTablet(context)) return 20;
    return 15;
  }
}

// Responsive breakpoints
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}

// Extension methods for easier usage
extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isLandscape => ResponsiveUtils.isLandscape(this);
  
  double get screenWidth => ResponsiveUtils.getScreenWidth(this);
  double get screenHeight => ResponsiveUtils.getScreenHeight(this);
  
  double get titleFontSize => ResponsiveUtils.getTitleFontSize(this);
  double get subtitleFontSize => ResponsiveUtils.getSubtitleFontSize(this);
  double get bodyFontSize => ResponsiveUtils.getBodyFontSize(this);
  
  double get buttonHeight => ResponsiveUtils.getButtonHeight(this);
  double get iconSize => ResponsiveUtils.getIconSize(this);
  double get logoSize => ResponsiveUtils.getLogoSize(this);
  
  EdgeInsets get responsivePadding => ResponsiveUtils.getPadding(this);
  EdgeInsets get cardPadding => ResponsiveUtils.getCardPadding(this);
  
  double get maxContentWidth => ResponsiveUtils.getMaxContentWidth(this);
  double get borderRadius => ResponsiveUtils.getBorderRadius(this);
  
  double getSpacing([double multiplier = 1.0]) => 
      ResponsiveUtils.getSpacing(this, multiplier: multiplier);
}
