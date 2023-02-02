import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../Screen/add_task_screen.dart';
import 'custom_button.dart';


class BuildTaskBar extends StatelessWidget {
  const BuildTaskBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme contextText = Theme.of(context).textTheme;
    bool isLand=MediaQuery.of(context).orientation==Orientation.landscape;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: contextText.bodyMedium,
              ),
              Text(
                'Today',
                style: contextText.headlineMedium!.copyWith(
                  fontSize:isLand? 25.sp: 30.sp,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        CustomButton(
          title: '+ Add Task',
          isBottom: false,
          onPressed: () => Navigator.of(context).pushNamed(AddTaskScreen.route),
        ),
      ],
    );
  }
}
