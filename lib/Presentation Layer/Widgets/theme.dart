import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../navigator_key.dart';

class Themes {
  static final light = ThemeData(
    primaryColor: const Color(0xFF4e5ae8),
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
      cardColor: Colors.white,
    ).copyWith(secondary: Colors.amber),
    scaffoldBackgroundColor: Colors.white,
    cardColor: const Color(0xFF4e5ae8),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: true,
      titleTextStyle: GoogleFonts.raleway(
        textStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w900,
          fontSize: 22.sp,
        ),
      ),
    ),
    textTheme: TextTheme(
      displayMedium: GoogleFonts.raleway(
          textStyle: TextStyle(
        color: customRed,
        fontWeight: FontWeight.w700,
        fontSize: 35.sp,
      )),
      displaySmall: GoogleFonts.lato(
        /// body notificationScreen
        textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 22.sp,
        ),
      ),
      headlineMedium: GoogleFonts.raleway(
        /// Used in titles CustomField
        textStyle: TextStyle(
          color: customRed,
          fontWeight: FontWeight.w900,
          fontSize: 22.sp,
        ),
      ),
      bodyMedium: TextStyle(
        /// Used in  date title

        fontSize: 24.sp,

        color: Colors.black,

        fontWeight: FontWeight.w800,
      ),
      titleSmall: GoogleFonts.raleway(
        /// Used in DatePicker (monthTextStyle && dayTextStyle && )
        textStyle: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w800,
          fontSize: 14.sp,
        ),
      ),
      bodySmall: TextStyle(
        /// Automatic programming with the screen that appears (a dialog box such as the theme dialog box) or (the start and end time dialog box in adding a task)
        color: customRed,

        fontWeight: FontWeight.w800,

        fontSize: 14.sp,
      ),
      bodyLarge: GoogleFonts.raleway(
        /// information Task in home
        textStyle: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      backgroundColor: Colors.black54,
      hourMinuteTextColor: customRed,
      hourMinuteColor: Colors.white12,
      dayPeriodShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      dayPeriodBorderSide: const BorderSide(color: Colors.grey),
      dayPeriodTextColor: customRed,
      helpTextStyle: TextStyle(fontSize: 15.sp, color: customRed),
      entryModeIconColor: customRed,
      hourMinuteTextStyle: TextStyle(fontSize: 23.sp),
      hourMinuteShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      dayPeriodTextStyle: TextStyle(fontSize: 15.sp),
      dialHandColor: customRed,
      dialTextColor: Colors.white,
      dialBackgroundColor: Colors.white12,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white12,
        filled: true,
      ),
    ),
  );

  static final dark = ThemeData(
    primaryColor: const Color(0xFF121212),
    backgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 51, 51, 51),
    cardColor: Colors.white12,
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
        foregroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: GoogleFonts.raleway(
            textStyle: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w900,
          fontSize: 22.sp,
        ))),
    textTheme: TextTheme(
      displayMedium: GoogleFonts.raleway(
        textStyle: TextStyle(
          color: const Color(0xFF4e5ae8),
          fontWeight: FontWeight.w700,
          fontSize: 35.sp,
        ),
      ),
      displaySmall: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w700,
          fontSize: 22.sp,
        ),
      ),
      headlineMedium: GoogleFonts.raleway(
        textStyle: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w900,
          fontSize: 22.sp,
        ),
      ),
      bodyMedium: TextStyle(
        /// Used in  date title

        fontSize: 24.sp,
        color: Colors.grey,
        fontWeight: FontWeight.w800,
      ),
      bodySmall: TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.w800,
        fontSize: 14.sp,
      ),
      titleSmall: GoogleFonts.raleway(
        /// Used in DatePicker (monthTextStyle && dayTextStyle && )
        textStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w800,
          fontSize: 16.sp,
        ),
      ),
      bodyLarge: GoogleFonts.raleway(
        /// information Task in home
        textStyle: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      backgroundColor: Colors.black54,
      hourMinuteTextColor: Colors.blueAccent,
      hourMinuteColor: Colors.white12,
      dayPeriodShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      dayPeriodBorderSide: const BorderSide(color: Colors.grey),
      dayPeriodTextColor: Colors.blueAccent,
      helpTextStyle: TextStyle(
        fontSize: 15.sp,
        color: Colors.blueAccent,
      ),
      entryModeIconColor: Colors.blueAccent,
      hourMinuteTextStyle: TextStyle(fontSize: 23.sp),
      hourMinuteShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      dayPeriodTextStyle: TextStyle(fontSize: 15.sp),
      dialHandColor: Colors.blueAccent,
      dialTextColor: Colors.white,
      dialBackgroundColor: Colors.white12,

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white12,
        filled: true,
      ),
    ),
  );
}
