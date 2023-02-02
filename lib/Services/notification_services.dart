import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_todo/Provider/task_mode.dart';
import 'package:flutter_todo/navigator_key.dart';
import 'package:intl/intl.dart';

import 'package:rxdart/rxdart.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../Presentation Layer/Screen/notification_screen.dart';

class NotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('notification payload: $payload');
        }
        selectNotificationSubject.add(payload!);
      },
    );
  }

  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      _nextInstanceOfTenAM(
          hour, minutes, task.remind!, task.repeat!, task.date!),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          'your channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  Future<void> cancelSingleTask(int taskID) async {
    await flutterLocalNotificationsPlugin.cancel(taskID);
  }

  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  tz.TZDateTime _nextInstanceOfTenAM(
    int hour,
    int minutes,
    int remind,
    String repeat,
    String date,
  ) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print('now= $now');

    var formattedDate = DateFormat.yMd().parse(date);
    final tz.TZDateTime df = tz.TZDateTime.from(formattedDate, tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, df.year, df.month, df.day, hour, minutes);
    print('scheduledDate= $scheduledDate');

    scheduledDate = afterRemind(remind, scheduledDate);

    /// Set the pat for the task

    if (scheduledDate.isBefore(now)) {
      if (repeat == 'Daily') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 1, hour, minutes);
      }
      if (repeat == 'Weekly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 7, hour, minutes);
      }
      if (repeat == 'Monthly') {


        scheduledDate = tz.TZDateTime(tz.local, now.year,
            (formattedDate.month) + 1, (formattedDate.day), hour, minutes);
      }
      scheduledDate = afterRemind(remind, scheduledDate);
    }
    print(' next scheduledDate== $scheduledDate');
    return scheduledDate;
  }

  tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
    if (remind == 0) {
      scheduledDate = scheduledDate;
    }
    if (remind == 5) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 5));
    }
    if (remind == 10) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 10));
    }
    if (remind == 15) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 15));
    }
    if (remind == 20) {
      scheduledDate = scheduledDate.add(const Duration(minutes: 20));
    }
    return scheduledDate;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

//Older IOS
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: navigatorKey!.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              await navigatorKey!.currentState!.push(
                MaterialPageRoute(
                  builder: (ctx) => NotificationScreen(
                    payload: payload!,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await navigatorKey!.currentState!.push(
        MaterialPageRoute(
          builder: (ctx) => NotificationScreen(
            payload: payload,
          ),
        ),
      );
    });
  }
}
