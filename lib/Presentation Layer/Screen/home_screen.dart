import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../navigator_key.dart';
import '../Widgets/no_tasks.dart';
import '../Widgets/task_tile.dart';
import '../../Provider/task_mode.dart';
import '../../Provider/task_provider.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';
import '../../Services/notification_services.dart';

import '../Widgets/appbar_image_person.dart';
import '../Widgets/build_task_bar.dart';
import '../Widgets/choose_theme.dart';
import '../Widgets/dialog_dangerous_zone.dart';

class HomeScreen extends StatefulWidget {
  static const route = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  late NotificationServices notificationServices;

  @override
  void initState() {
    super.initState();
    notificationServices = NotificationServices();
    notificationServices.initializeNotification();
    notificationServices.requestIOSPermissions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ThemeProvider>(context, listen: false).getTheme();

    Provider.of<TaskProvider>(context, listen: false).getTasks();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    TextTheme contextText = Theme.of(context).textTheme;

    return FutureBuilder(
        future: Provider.of<TaskProvider>(context, listen: false).getTasks(),
        builder: (context, _) => Scaffold(
              appBar: buildAppBar(contextText, context),
              body: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    SizedBox(height: deviceSize.height * 0.03),
                    isLand ? const SizedBox() : const BuildTaskBar(),
                    _buildDateBar(context: context),
                    _buildShowTask(context),
                    SizedBox(height: deviceSize.height * 0.03),
                  ],
                ),
              ),
            ));
  }

  AppBar buildAppBar(
    TextTheme contextText,
    BuildContext context,
  ) {
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    var taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return AppBar(
      leading: const ChooseTheme(),
      title: isLand
          ? Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: const BuildTaskBar(),
            )
          : const SizedBox(),
      actions: [
        DangerousZone(
          onPressed: () async {
            Navigator.pop(context);
            taskProvider.deleteAll();
            await notificationServices.cancelAll();
          },
        ),
        isLand ? const SizedBox() : const AppBarImagePerson(),
      ],
    );
  }

  _buildDateBar({
    required BuildContext context,
  }) {
    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;

    TextStyle? style = Theme.of(context).textTheme.titleSmall;
    Color color =
        isDark ? Colors.blueAccent : const Color.fromARGB(255, 255, 51, 51);

    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: color,
        selectedTextColor: isDark ? Colors.black : Colors.white,
        monthTextStyle: style!,
        dateTextStyle: style.copyWith(
          fontSize: 19.sp,
        ),
        dayTextStyle: style,
        width: 70.w,
        height: 90.h,
        onDateChange: (newDate) {
          setState(() => _selectedDate = newDate);
        },
      ),
    );
  }

  Future<void> _refreshIndicator() async =>
      Provider.of<TaskProvider>(context, listen: false).getTasks();

  _buildShowTask(BuildContext context) {
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;

    List<Task> tasksProvider =
        Provider.of<TaskProvider>(context, listen: true).tasksList;

    if (tasksProvider.isEmpty) {
      return const NoTasks();
    } else {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: _refreshIndicator,
          child: ListView.builder(
            scrollDirection: isLand ? Axis.horizontal : Axis.vertical,
            itemCount: tasksProvider.length,
            itemBuilder: (context, index) {
              Task task = Provider.of<TaskProvider>(context, listen: false)
                  .tasksList[index];

              if (task.repeat == 'Daily' ||
                  task.date == DateFormat.yMd().format(_selectedDate) ||
                  (task.repeat == 'Weekly' &&
                      _selectedDate
                                  .difference(
                                      DateFormat.yMd().parse(task.date!))
                                  .inDays %
                              7 ==
                          0) ||
                  _selectedDate.day == DateFormat.yMd().parse(task.date!).day) {
                DateTime date = DateFormat.jm().parse(task.startTime!);
                String myDate = DateFormat('HH:mm').format(date);
                var hour = int.parse(myDate.toString().split(':')[0]);
                var minutes = int.parse(myDate.toString().split(':')[1]);
                notificationServices.scheduledNotification(hour, minutes, task);

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          bottomSheetController(
                            context,
                            task,
                          );
                        },
                        child: TaskTile(task: task),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      );
    }
  }
}
