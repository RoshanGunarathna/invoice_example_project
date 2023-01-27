import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/colors.dart';
import 'package:invoice/router.dart';

import 'features/home/screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'invoice',
        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepOrange),
        ),
        home: const HomeScreen(),
        onGenerateRoute: (settings) => generateRoutes(settings),
      );
}
