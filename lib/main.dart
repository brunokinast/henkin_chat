import 'package:henkin_chat/firebase_options.dart';
import 'package:henkin_chat/utils/settings.dart';
import 'package:henkin_chat/views/auth_screen.dart';
import 'package:henkin_chat/views/chat_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Settings.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Settings.listenable,
      builder: (_, __, ___) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HenkinChat',
          theme: ThemeData(
            primaryColor: Settings.appColor,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Settings.appMaterialColor,
              accentColor: Colors.deepOrange,
            ),
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Theme.of(context).primaryColor,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (_, snap) {
              if (snap.hasError)
                return Scaffold(
                  body: Center(
                    child: Text('${snap.error}'),
                  ),
                );
              if (snap.hasData)
                return StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (_, snap) {
                    if (snap.hasData) return ChatMainScreen();
                    return AuthScreen();
                  },
                );
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
