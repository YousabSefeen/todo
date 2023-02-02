import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  final String payload;

  const NotificationScreen({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var date = DateFormat('hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    ThemeData ctx = Theme.of(context);
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25.h,
          ),
          iconSize: 25.h,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) => Column(
            children: [
              SizedBox(
                height: isLand
                    ? constraint.maxHeight * 0.3
                    : constraint.maxHeight * 0.15,
                child: Column(
                  children: [
                    Text(
                      'Task',
                      style: ctx.textTheme.displayMedium!.copyWith(
                        fontSize: 40.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'You have a new remind.',
                      style: ctx.textTheme.displaySmall!.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isLand
                    ? constraint.maxHeight * 0.4
                    : constraint.maxHeight * 0.8,
                child: Card(
                  color: const Color.fromARGB(255, 41, 31, 71),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: isLand ? 30.h : 15.h, horizontal: 13.w),
                    child: ListView(
                      scrollDirection: isLand ? Axis.horizontal : Axis.vertical,
                      children: [
                        buildTextTitles(
                          context: context,
                          title: 'Title ',
                          lineWidth: isLand ? 35.w : 70.w,
                        ),
                        buildText(
                          context: context,
                          string: widget.payload.toString().split('|')[0],
                        ),
                        buildTextTitles(
                          context: context,
                          title: 'Description ',
                          lineWidth: isLand ? 93.w : 188.w,
                        ),
                        buildText(
                          context: context,
                          string: widget.payload.toString().split('|')[1],
                        ),
                        buildTextTitles(
                          context: context,
                          title: 'Date',
                          lineWidth: isLand ? 35.w : 73.w,
                        ),
                        buildText(
                          context: context,
                          string: widget.payload.toString().split('|')[2],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: constraint.maxHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildText({
    required BuildContext context,
    required String string,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 15, left: 2, right: 7),
      child: Text(
        string,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22.sp,
          ),
        ),
      ),
    );
  }

  Column buildTextTitles({
    required BuildContext context,
    required String title,
    required double lineWidth,
  }) {
    TextStyle? displayMedium = Theme.of(context).textTheme.displayMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: displayMedium!.copyWith(color: Colors.blue),
        ),
        Container(
          height: 3.h,
          width: lineWidth,
          color: Colors.amber,
        )
      ],
    );
  }
}
