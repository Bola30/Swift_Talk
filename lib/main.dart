import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_talk_2/core/utils/theme.dart';
import 'package:swift_talk_2/pages/chat_page.dart';
import 'package:swift_talk_2/pages/cubits/cubit/login_cubit.dart';
import 'package:swift_talk_2/pages/cubits/cubit/signup_cubit/signup_cubit.dart';
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
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginCubit(_auth)),
            BlocProvider(create: (context) => SignUpCubit(_auth)),
          ],
          child: MaterialApp(
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
          ),
        );
      },
    );
  }
}
