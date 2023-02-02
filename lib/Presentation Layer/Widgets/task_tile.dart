import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo/Provider/task_mode.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.bodyLarge;
    Size deviceSize = MediaQuery.of(context).size;

    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: _getColor(task.color),
      ),
      width: isLandScape ? deviceSize.width / 2 : deviceSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    task.title!,
                    style: style,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(Icons.access_alarm_outlined,
                                size: isLandScape ? 26.h : 26.h,
                                color: style!.color!,),
                          ),
                          Text('${task.startTime}',
                              style: GoogleFonts.lato(textStyle: style,),),
                        ],
                      ),
                      Text(
                        task.note!,
                        style: style,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(height: 70.h, width: 3.w, color: Colors.black54),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 0 ? 'TODO' : 'COMPLETED',
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  _getColor(int? color) {
    switch (color) {
      case 0:
        return const Color.fromARGB(255, 255, 51, 51);

      case 1:
        return const Color(0xFF4e5ae8);
      case 2:
        return Colors.amber;
    }
  }
}
