import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/appbar_image_person.dart';

import '../../Provider/task_mode.dart';
import '../../Provider/task_provider.dart';
import '../../navigator_key.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_field.dart';

class AddTaskScreen extends StatefulWidget {
  static const route = 'AddTaskScreen';

  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  int _initialRemind = 0;
  final List<int> _remindList = [0, 5, 10, 15, 20];
  String _initialRepeat = 'None';
  final List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;

    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    Color iconColor =
        isDark ? Colors.blueAccent : const Color.fromARGB(255, 255, 51, 51);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: iconColor, size: 27.h),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          AppBarImagePerson(),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              CustomField(
                title: 'Title',
                hint: 'Enter the title',
                controller: _titleController,
              ),
              CustomField(
                title: 'Note',
                hint: 'Enter the note',
                maxLines: 2,
                controller: _noteController,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomField(
                      title: 'Time',
                      hint: _startTime,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.access_alarm_outlined,
                          color: iconColor,
                          size: 27.h,
                        ),
                        onPressed: () => _addTime(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      title: 'Date Time',
                      hint: DateFormat.yMd().format(_selectedDate),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: iconColor,
                          size: 27.h,
                        ),
                        onPressed: () async {
                          var newDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
                          );
                          setState(
                              () => _selectedDate = newDate ?? _selectedDate);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              CustomField(
                title: 'Remind',
                hint: '$_initialRemind minutes early',
                suffixIcon: DropdownButton(
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(12.r),
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: iconColor,
                    size: 27.h,
                  ),
                  items: _remindList
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text('${value.toString()} m'),
                          ))
                      .toList(),
                  onChanged: (int? newValue) {
                    setState(() => _initialRemind = newValue!);
                  },
                ),
              ),
              CustomField(
                title: 'Repeat',
                hint: _initialRepeat,
                suffixIcon: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: iconColor,
                    size: 27.h,
                  ),
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(12.r),
                  items: _repeatList
                      .map(
                        (values) => DropdownMenuItem(
                          value: values,
                          child: Text(values),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) =>
                      setState(() => _initialRepeat = newValue!),
                ),
              ),
              Row(
                children: [
                  buildColorPalette(context),
                  const Spacer(),
                  CustomButton(
                    title: 'Create Task',
                    isBottom: false,
                    onPressed: () {
                      if (_titleController.text == '' &&
                          _noteController.text == '') {
                        showSnackBar(
                          context: context,
                          msg: 'Please fill in the title and note field',
                        );
                      } else if (_titleController.text == '') {
                        showSnackBar(
                          context: context,
                          msg: 'Please fill in the title field',
                        );
                      } else if (_noteController.text == '') {
                        showSnackBar(
                          context: context,
                          msg: 'Please fill in the note field',
                        );
                      } else {
                        _addTask(context);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  _addTime() async {
    TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(DateFormat('hh:mm a').parse(_startTime)),
    );
    String? timeFormatted = newTime?.format(context);

    if (timeFormatted != null) {
      setState(() => _startTime = timeFormatted);
    } else {
      print('No selected time');
    }
  }

  _addTask(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        remind: _initialRemind,
        repeat: _initialRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
  }

  Padding buildColorPalette(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 30.sp,
                ),
          ),
          Row(
            children: List.generate(
              3,
              (index) => GestureDetector(
                onTap: () {
                  setState(() => _selectedColor = index);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: CircleAvatar(
                    backgroundColor: index == 0
                        ? const Color.fromARGB(255, 255, 51, 51)
                        : index == 1
                            ? const Color(0xFF4e5ae8)
                            : Colors.amber,
                    child: _selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 25.h,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
