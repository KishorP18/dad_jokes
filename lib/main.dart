import 'package:dad_jokes/router.dart';
import 'package:dad_jokes/util/theme.dart';
import 'package:flutter/material.dart';
import 'injector.dart';

void main() {
  setupInjector();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dad's Quiz",
      theme: JokeAppThemeData.darkThemeData,
      debugShowCheckedModeBanner: false,
      onGenerateRoute:Routes.generateRoute,
      initialRoute: Routes.home,
    );
  }
}


