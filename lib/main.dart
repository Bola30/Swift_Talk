import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/theme.dart';
import 'package:swift_talk_2/pages/chat_page.dart';
import 'package:swift_talk_2/pages/logIn_page.dart';
import 'package:swift_talk_2/pages/signup_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SwiftTalk());
}

class SwiftTalk extends StatelessWidget {
  const SwiftTalk({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
      ThemeMode.system,
    );

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          routes: {
            'LoginPage': (context) => LoginPage(),
            'SignupPage': (context) => SignUpPage(),
            'ChatPage': (context) => ChatPage(),
          },
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: currentTheme,
          home: LoginPage(),
        );
      },
    );
  }
}
