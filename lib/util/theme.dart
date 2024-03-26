import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Color> textColorLight = [
  const Color(0XFF1C1C1C),
  const Color(0XFF434343),
  const Color(0XFF636363),
  const Color(0XFF7F7F7F)
];
final List<Color> textColorDark = [
  const Color(0XFFFAFAFA),
  const Color(0XFFDFDFDF),
  const Color(0XFFD3D3D3),
  const Color(0XFFBFBFBF)
];

// Light Color Scheme
ColorScheme lightColorScheme = const ColorScheme(
  primary: Colors.cyan,
  secondary: Colors.teal,
  tertiary: Colors.orange,
  background: Colors.white,
  surface: Color(0XFFEBEBEB),
  surfaceVariant: Colors.white12,
  onBackground: Colors.black87,
  error: Colors.red,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onTertiary: Colors.white,
  onSurface: Colors.black87,
  brightness: Brightness.light,
  primaryContainer: Colors.blue,
  secondaryContainer: Colors.green,
  tertiaryContainer: Colors.deepOrange,
  errorContainer: Color(0XFFEF9A9A),
  onErrorContainer: Colors.white,
  onPrimaryContainer: Color(0XFFFAFAFA),
  onSecondaryContainer: Color(0XFFDFDFDF),
  onTertiaryContainer: Color(0XFFD3D3D3),
  onSurfaceVariant: Color(0XFF575757),
  onInverseSurface: Colors.black12,
);

// Dark Color Scheme
ColorScheme darkColorScheme = const ColorScheme(
  primary: Color(0XFF00838F),
  secondary: Color(0XFF80CBC4),
  tertiary: Color(0XFFFFCC80),
  background: Colors.black,
  surface: Colors.white24,
  surfaceVariant: Colors.white54,
  onBackground: Colors.white70,
  error: Color(0XFFEF9A9A),
  errorContainer: Color(0XFFFFCDD2),
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onTertiary: Colors.white,
  onSurface: Colors.white70,
  brightness: Brightness.dark,
  primaryContainer: Color(0XFF90CAF9),
  secondaryContainer: Color(0XFFA5D6A7),
  tertiaryContainer: Color(0XFFFFAB91),
  onErrorContainer: Colors.white12,
  onPrimaryContainer: Color(0XFF1C1C1C),
  onSecondaryContainer: Color(0XFF434343),
  onTertiaryContainer: Color(0XFF636363),
  onSurfaceVariant: Color(0XFFAFAFAF),
  onInverseSurface: Colors.white54,
);

final Color _lightFocusColor = Colors.black.withOpacity(0.12);
final Color _darkFocusColor = Colors.white.withOpacity(0.12);

final ThemeData lightThemeData = themeData(
    lightColorScheme, _lightFocusColor, textColorLight, textColorDark);
final ThemeData darkThemeData =
    themeData(darkColorScheme, _darkFocusColor, textColorDark, textColorLight);

ThemeData themeData(ColorScheme colorScheme, Color focusColor,
    List<Color> textColor, List<Color> borderColors) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    disabledColor: colorScheme.onSurface,
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.ptSans(
          fontSize: 16,
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold),
      color: colorScheme.primary,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colorScheme.primary,
          statusBarIconBrightness: colorScheme.brightness,
          systemNavigationBarColor: colorScheme.secondary,
          systemNavigationBarIconBrightness: colorScheme.brightness),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
    ),
    iconTheme: IconThemeData(color: colorScheme.onPrimary),
    canvasColor: colorScheme.secondary,
    scaffoldBackgroundColor: colorScheme.background,
    highlightColor: Colors.transparent,
    focusColor: focusColor,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.ptSans(
        fontSize: 57,
        fontWeight: FontWeight.w300,
        color: textColor[0],
      ),
      displayMedium: GoogleFonts.ptSans(
        fontSize: 45,
        fontWeight: FontWeight.w300,
        color: textColor[0],
      ),
      displaySmall: GoogleFonts.ptSans(
        fontSize: 36,
        fontWeight: FontWeight.w300,
        color: textColor[0],
      ),
      headlineLarge: GoogleFonts.ptSans(
        fontSize: 32,
        fontWeight: FontWeight.normal,
        color: textColor[0],
      ),
      headlineMedium: GoogleFonts.ptSans(
        fontSize: 28,
        fontWeight: FontWeight.normal,
        color: textColor[0],
      ),
      headlineSmall: GoogleFonts.ptSans(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: textColor[0],
      ),
      titleLarge: GoogleFonts.ptSans(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: textColor[1],
      ),
      titleMedium: GoogleFonts.ptSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor[1],
      ),
      titleSmall: GoogleFonts.ptSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor[1],
      ),
      bodyLarge: GoogleFonts.ptSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor[2],
      ),
      bodyMedium: GoogleFonts.ptSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor[2],
      ),
      bodySmall: GoogleFonts.ptSans(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textColor[2],
      ),
      labelLarge: GoogleFonts.ptSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor[3],
      ),
      labelMedium: GoogleFonts.ptSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor[3],
      ),
      labelSmall: GoogleFonts.ptSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor[3],
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            //primary: colorScheme.onPrimary,
            foregroundColor: colorScheme.onPrimary,
            textStyle: GoogleFonts.ptSans(
              color: Colors.white,
            ))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: colorScheme.primary,
      disabledBackgroundColor: colorScheme.onSurface,
      disabledForegroundColor: colorScheme.surfaceVariant,
      textStyle: GoogleFonts.ptSans(
        color: colorScheme.onPrimary,
      ),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        textStyle: GoogleFonts.ptSans(
          color: colorScheme.primary,
        ),
        side: BorderSide(color: colorScheme.primary, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12),
      isDense: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusColor: colorScheme.primary,
      enabledBorder: _buildBorder(borderColors[1]),
      errorBorder: _buildBorder(colorScheme.error),
      focusedErrorBorder: _buildBorder(colorScheme.errorContainer),
      border: _buildBorder(borderColors[1]),
      focusedBorder: _buildBorder(colorScheme.primary),
      disabledBorder: _buildBorder(borderColors[3]),
      //text
      suffixStyle: _buildTextStyle(textColor[1]),
      prefixStyle: _buildTextStyle(textColor[1]),
      counterStyle: _buildTextStyle(textColor[3]),
      floatingLabelStyle: _buildTextStyle(textColor[1]),
      errorStyle: _buildTextStyle(colorScheme.error, size: 12.0),
      helperStyle: _buildTextStyle(textColor[3], size: 12.0),
      hintStyle: _buildTextStyle(textColor[3]),
      labelStyle: _buildTextStyle(textColor[1]),
      iconColor: textColor[1],
    ),
    dividerColor: textColor[3],
  );
}

OutlineInputBorder _buildBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(7)),
    gapPadding: 3,
    borderSide: BorderSide(
      color: color,
      width: 1.0,
    ),
  );
}

TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
  return TextStyle(
    color: color,
    fontSize: size,
  );
}
