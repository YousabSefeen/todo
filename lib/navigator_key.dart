import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo/Services/notification_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Presentation Layer/Widgets/custom_button.dart';
import 'Provider/task_mode.dart';
import 'Provider/task_provider.dart';
import 'Provider/theme_provider.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

// This line is to go to another page and the page must be defined in the routes on the main page

const Color customRed = Color.fromARGB(255, 255, 51, 51);

showSnackBar({
  required BuildContext context,
  required String msg,
}) {
  SnackBar sB = SnackBar(
    content: Text(msg,
        textAlign: TextAlign.start,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        )),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(sB);
}

bottomSheetController(BuildContext context, Task task) {
  bool isDark = Provider.of<ThemeProvider>(context, listen: false).theme ==
      ThemeMode.dark;
  var taskProvider = Provider.of<TaskProvider>(context, listen: false);
  ThemeMode.dark;
  bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        color: isDark ? Colors.black54 : Colors.white,
        height: isLand ? 150.h : null,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                height: 7,
                width: 80.w,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              task.isCompleted == 0
                  ? CustomButton(
                      title: 'Task Completed',
                      isBottom: true,
                      onPressed: () async {
                        taskProvider.updateTask(task.id!);
                        Navigator.of(context).pop();
                        await NotificationServices().cancelSingleTask(task.id!);
                      },
                    )
                  : const SizedBox(),
              CustomButton(
                deleteColor: isDark ? Colors.red : Colors.black,
                title: 'Delete Task',
                isBottom: true,
                onPressed: () async {
                  taskProvider.deleteTask(task);
                  Navigator.of(context).pop();
                  await NotificationServices().cancelSingleTask(task.id!);
                },
              ),
              CustomButton(
                title: 'Cancel',
                isBottom: true,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      );
    },
  );
}
