import 'package:flutter/material.dart';
import 'package:lab_10_sqlite/add_user.dart';
import 'package:lab_10_sqlite/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SQFlite Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => UserPage(),
          '/adduser': (context) => AddUserPage(),
        },
        
        );
  }
}

