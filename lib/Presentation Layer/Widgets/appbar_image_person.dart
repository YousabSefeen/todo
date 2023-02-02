import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarImagePerson extends StatelessWidget {
  const AppBarImagePerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, right: 8.w),
      child: CircleAvatar(
        backgroundImage: const AssetImage('images/person.jpeg'),
        radius: 23.r,
      ),
    );
  }
}
