import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo/Provider/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../navigator_key.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool isBottom;
  final Color? deleteColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.isBottom,
    this.deleteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
        right: isBottom ? 0 : 5.w,
        bottom: isBottom ? 0 : 7.h,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            isBottom
                ? EdgeInsets.symmetric(vertical: 10.h, horizontal: 35.w)
                : const EdgeInsets.all(10),
          ),
          backgroundColor: MaterialStateProperty.all(
             deleteColor ?? (isDark ? Colors.blueAccent : customRed),

          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isBottom ? 20.r : 12.r),
            ),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: !isLand
                  ? (isBottom ? 27.sp : 20.sp)
                  : (isBottom ? 15.sp : 16.sp),
              color: isDark ? Colors.black : Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
