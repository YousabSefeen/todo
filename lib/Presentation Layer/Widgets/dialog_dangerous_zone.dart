import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/task_provider.dart';
import '../../Provider/theme_provider.dart';


class DangerousZone extends StatelessWidget {

 final void Function()? onPressed;
    const DangerousZone({Key? key ,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    var taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return    Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(
          Icons.cleaning_services_outlined,
          color: Colors.red,
          size: 30.h,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                    size: 25.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      'Dangerous zone ',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              content: Text(
                'Are you sure you have completed all your tasks?',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey : Colors.black54),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cansel'),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
