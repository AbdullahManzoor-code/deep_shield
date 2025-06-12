// import 'package:flutter/material.dart';

// class AppTheme {
//   // Colors
//   static const Color primaryColor = Color(0xFF8A2BE2); // Purple
//   static const Color secondaryColor = Color(0xFF00FFFF); // Cyan
//   static const Color accentColor = Color(0xFF0080FF); // Blue
//   static const Color backgroundColor = Color(0xFF0A0A0A); // Dark
//   static const Color surfaceColor = Color(0xFF1A1A1A); // Dark surface
//   static const Color cardColor = Color(0xFF2A2A2A); // Card background
  
//   // Gradients
//   static const LinearGradient primaryGradient = LinearGradient(
//     colors: [
//       Color(0xFF8A2BE2), // Purple
//       Color(0xFF6A1B9A), // Darker purple
//     ],
//   );
  
//   static const LinearGradient logoGradient = RadialGradient(
//     colors: [
//       Color(0xFF00FFFF), // Cyan
//       Color(0xFF0080FF), // Blue
//       Color(0xFF8A2BE2), // Purple
//     ],
//     stops: [0.0, 0.6, 1.0],
//   );
  
//   static const LinearGradient backgroundGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [
//       Color(0xFF2D1B69), // Deep purple
//       Color(0xFF0A0A0A), // Black
//       Color(0xFF1A237E), // Indigo
//     ],
//   );
  
//   static const LinearGradient cardGradient = LinearGradient(
//     colors: [
//       Color(0x14FFFFFF), // Semi-transparent white
//       Color(0x0AFFFFFF), // More transparent white
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
  
//   // Text Styles
//   static const TextStyle headingStyle = TextStyle(
//     color: Colors.white,
//     fontWeight: FontWeight.bold,
//     letterSpacing: 1.2,
//   );
  
//   static const TextStyle subheadingStyle = TextStyle(
//     color: Colors.white,
//     fontWeight: FontWeight.w600,
//     letterSpacing: 0.8,
//   );
  
//   static const TextStyle bodyStyle = TextStyle(
//     color: Colors.white,
//     fontWeight: FontWeight.w500,
//   );
  
//   static const TextStyle captionStyle = TextStyle(
//     color: Color(0xFFB0B0B0),
//     fontWeight: FontWeight.w400,
//   );
  
//   // Button Styles
//   static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
//     backgroundColor: primaryColor,
//     foregroundColor: Colors.white,
//     elevation: 8,
//     shadowColor: primaryColor.withOpacity(0.5),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );
  
//   static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
//     backgroundColor: Colors.transparent,
//     foregroundColor: Colors.white,
//     elevation: 0,
//     side: BorderSide(
//       color: Colors.white.withOpacity(0.3),
//       width: 2,
//     ),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );
  
//   // Card Decoration
//   static BoxDecoration cardDecoration = BoxDecoration(
//     gradient: cardGradient,
//     borderRadius: BorderRadius.circular(20),
//     border: Border.all(
//       color: Colors.white.withOpacity(0.1),
//       width: 1,
//     ),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.3),
//         blurRadius: 15,
//         offset: const Offset(0, 5),
//       ),
//     ],
//   );
  
//   // Elevated Card Decoration
//   static BoxDecoration elevatedCardDecoration = BoxDecoration(
//     gradient: cardGradient,
//     borderRadius: BorderRadius.circular(25),
//     border: Border.all(
//       color: Colors.white.withOpacity(0.1),
//       width: 1,
//     ),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.4),
//         blurRadius: 20,
//         offset: const Offset(0, 10),
//       ),
//     ],
//   );
  
//   // Logo Container Decoration
//   static BoxDecoration logoDecoration = BoxDecoration(
//     shape: BoxShape.circle,
//     gradient: logoGradient,
//     boxShadow: [
//       BoxShadow(
//         color: secondaryColor.withOpacity(0.5),
//         blurRadius: 30,
//         spreadRadius: 5,
//       ),
//       BoxShadow(
//         color: primaryColor.withOpacity(0.3),
//         blurRadius: 50,
//         spreadRadius: 10,
//       ),
//     ],
//   );
  
//   // App Bar Theme
//   static const AppBarTheme appBarTheme = AppBarTheme(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     centerTitle: true,
//     titleTextStyle: TextStyle(
//       color: Colors.white,
//       fontSize: 24,
//       fontWeight: FontWeight.bold,
//       letterSpacing: 1.2,
//     ),
//   );
  
//   // Animation Durations
//   static const Duration shortAnimation = Duration(milliseconds: 200);
//   static const Duration mediumAnimation = Duration(milliseconds: 300);
//   static const Duration longAnimation = Duration(milliseconds: 500);
  
//   // Border Radius Values
//   static const double smallRadius = 12.0;
//   static const double mediumRadius = 20.0;
//   static const double largeRadius = 25.0;
  
//   // Spacing Values
//   static const double smallSpacing = 8.0;
//   static const double mediumSpacing = 16.0;
//   static const double largeSpacing = 24.0;
//   static const double extraLargeSpacing = 32.0;
  
//   // Helper Methods
//   static BoxShadow createShadow({
//     Color? color,
//     double blurRadius = 10,
//     Offset offset = const Offset(0, 5),
//     double opacity = 0.3,
//   }) {
//     return BoxShadow(
//       color: (color ?? Colors.black).withOpacity(opacity),
//       blurRadius: blurRadius,
//       offset: offset,
//     );
//   }
  
//   static LinearGradient createGradient(List<Color> colors) {
//     return LinearGradient(
//       colors: colors,
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     );
//   }
  
//   static BoxDecoration createCardDecoration({
//     List<Color>? gradientColors,
//     double borderRadius = mediumRadius,
//     Color? borderColor,
//     List<BoxShadow>? shadows,
//   }) {
//     return BoxDecoration(
//       gradient: gradientColors != null 
//           ? createGradient(gradientColors)
//           : cardGradient,
//       borderRadius: BorderRadius.circular(borderRadius),
//       border: borderColor != null 
//           ? Border.all(color: borderColor, width: 1)
//           : Border.all(color: Colors.white.withOpacity(0.1), width: 1),
//       boxShadow: shadows ?? [
//         createShadow(),
//       ],
//     );
//   }
  
//   // Status Colors
//   static const Color successColor = Color(0xFF4CAF50);
//   static const Color warningColor = Color(0xFFFF9800);
//   static const Color errorColor = Color(0xFFF44336);
//   static const Color infoColor = Color(0xFF2196F3);
  
//   // Theme Data
//   static ThemeData get themeData {
//     return ThemeData(
//       primarySwatch: createMaterialColor(primaryColor),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: appBarTheme,
//       useMaterial3: true,
//       fontFamily: 'Roboto',
//       colorScheme: const ColorScheme.dark(
//         primary: primaryColor,
//         secondary: secondaryColor,
//         surface: surfaceColor,
//         background: backgroundColor,
//         onPrimary: Colors.white,
//         onSecondary: Colors.white,
//         onSurface: Colors.white,
//         onBackground: Colors.white,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: primaryButtonStyle,
//       ),
//     );
//   }
  
//   // Helper to create MaterialColor from Color
//   static MaterialColor createMaterialColor(Color color) {
//     List strengths = <double>[.05];
//     final swatch = <int, Color>{};
//     final int r = color.red, g = color.green, b = color.blue;

//     for (int i = 1; i < 10; i++) {
//       strengths.add(0.1 * i);
//     }
    
//     for (var strength in strengths) {
//       final double ds = 0.5 - strength;
//       swatch[(strength * 1000).round()] = Color.fromRGBO(
//         r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//         g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//         b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//         1,
//       );
//     }
    
//     return MaterialColor(color.value, swatch);
//   }
// }
