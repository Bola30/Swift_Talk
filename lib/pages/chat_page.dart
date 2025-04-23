/* import 'package:flutter/material.dart';
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
                color: AppInfo.kPrimaryColor2,
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
 */
import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/costants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppInfo.kPrimaryColor2,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Swift Talk",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppInfo.kPrimaryColor2),
            ),
            Image.asset(AppInfo.kLogo2 , height: 150, width: 50),
          ],
        ),
      ),
      body: Center(child: Text('Bola🚀😍')),
    );
  }
}
