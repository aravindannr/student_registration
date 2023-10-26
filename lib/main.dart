import 'package:flutter/material.dart';
import 'package:task_one/screens/firstPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_one/screens/updateDetailes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration Form',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey),
                side: MaterialStateProperty.all(const BorderSide(
                  color: Colors.white,
                )),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))))),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey,
          iconSize: 25,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        fontFamily: 'Roboto',
      ),
      home: FirstPage(),
      routes: {
        '/update' : (context) => UpdateDetailes()
      },
    );
  }
}
