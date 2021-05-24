import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:two_tomatos/design/tomato_colors.dart';
import 'package:two_tomatos/design/tomato_theme.dart';
import 'package:two_tomatos/screens/launch_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: TomatoColors.tomatoDarkRed));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: TomatoTheme.mainTheme,
      home: LaunchScreen(),
    );
  }
}


