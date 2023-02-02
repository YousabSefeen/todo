import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String title, hint;
  final Widget? widget;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int? maxLines;

  const CustomField({
    Key? key,
    required this.title,
    required this.hint,
    this.widget,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    return Container(
      margin: EdgeInsets.only(left: 13.w, top: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium!),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    maxLines: maxLines,
                    validator: validator,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 7.0.w),
                        child: suffixIcon,
                      ),
                    ),
                    autofocus: false,
                    readOnly: suffixIcon != null,
                    controller: controller,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: isDark ? Colors.grey[300] : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
