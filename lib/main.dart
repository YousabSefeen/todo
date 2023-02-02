import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_todo/Presentation%20Layer/Widgets/theme.dart';

import 'package:flutter_todo/Provider/task_provider.dart';
import 'package:provider/provider.dart';

import 'Presentation Layer/Screen/add_task_screen.dart';
import 'Presentation Layer/Screen/home_screen.dart';
import 'Provider/theme_provider.dart';
import 'Services/db_helper.dart';
import 'navigator_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initializeDataBase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: Provider.of<ThemeProvider>(context, listen: true).theme,
        home: const HomeScreen(),
        routes: {
          HomeScreen.route: (context) => const HomeScreen(),
          AddTaskScreen.route: (context) => const AddTaskScreen(),
        },
      ),
    );
  }
}
