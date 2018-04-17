import 'package:flutter/material.dart';
import 'MainScreen.dart';

var app = new MaterialApp(
  title: 'Soundboard',
  home: new MainScreen(),
  theme: ThemeData(
          accentColor: Colors.redAccent,
          primaryColor: Colors.red
  ),
);

void main() => runApp(app);