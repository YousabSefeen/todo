import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';


class ChooseTheme extends StatelessWidget {
  const ChooseTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isDark=Provider.of<ThemeProvider>(context).theme==ThemeMode.dark;
    bool isLand=MediaQuery.of(context).orientation==Orientation.landscape;
    Size deviceSize=MediaQuery.of(context).size;
    return IconButton(
      icon: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Icon(
          isDark ? Icons.sunny : Icons.dark_mode_rounded,
          size: 30.sp,
          color: isDark ? Colors.amber : Colors.black,
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              contentPadding:   EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              content: SizedBox(
                height: isLand ? deviceSize.height * .5 : deviceSize.height * .22,
                child: Column(
                  children: [
                    buildRadioListTile(
                      valueTheme: ThemeMode.system,
                      title: 'System Mode',
                      context: context,
                    ),
                    buildRadioListTile(
                      valueTheme: ThemeMode.light,
                      title: 'Light Mode',
                      icon: Icons.sunny,
                      context: context,
                    ),
                    buildRadioListTile(
                        valueTheme: ThemeMode.dark,
                        title: 'Dark Mode',
                        icon: Icons.dark_mode_rounded,
                        context: context,
                        isSunny: false),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  buildRadioListTile({
    required ThemeMode valueTheme,
    required String title,
    IconData? icon,
    required BuildContext context,
    bool isSunny = true,
  }) {
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      height: isLand ? deviceSize.height * 0.15 : deviceSize.height * 0.07,
      child: RadioListTile(
        value: valueTheme,
        groupValue: Provider.of<ThemeProvider>(context).theme,
        title: Text(
          title,
          style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
        ),
        secondary: Icon(
          icon,
          size: 25.sp,
          color: isSunny ? Colors.amber : Colors.black,
        ),
        onChanged: (newTheme) {
          Provider.of<ThemeProvider>(context, listen: false)
              .onChangeTheme(newTheme);
          Navigator.pop(context);
        },
      ),
    );
  }
}
