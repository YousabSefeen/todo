import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    Color color =
        isDark ? Colors.blueAccent : const Color.fromARGB(255, 255, 51, 51);
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 3000),
                child: Wrap(
                  direction: isLand ? Axis.horizontal : Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/task.svg',
                      height: 150.h,
                      color: color.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'You do not have any tasks yet!\nAdd new tasks to make your days productive ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
