import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/costants.dart';
import 'package:swift_talk_2/core/utils/theme.dart';

class HomePage extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: currentTheme,
          home: Scaffold(
            appBar: AppBar(
              elevation: 2,
              centerTitle: true,
              title: Text(
                'Swift Talk 🚀',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
            body: Center(
              child: Text(
                'Current Theme: ${themeNotifier.value == ThemeMode.light ? "Light" : "Dark"}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                themeNotifier.value =
                    themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                         : ThemeMode.light;
              },
              child: Icon(
                size: 40,
                color: AppColors.kPrimaryColor2,
                themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
          ),
        );
      },
    );
  }
}
