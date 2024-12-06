import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:project_app/main_api.dart';
import 'package:project_app/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: ApiTest(),
      initialRoute: '/home',
      routes: appRoutes,
    );
  }
}
