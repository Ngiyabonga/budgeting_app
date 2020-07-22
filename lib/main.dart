import 'package:flutter/material.dart';
import 'package:budgeting_app/Services/authentication.dart';
import 'package:budgeting_app/root_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Budgeting App',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth())
    );
  }
}