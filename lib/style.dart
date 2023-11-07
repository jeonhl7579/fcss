import 'package:flutter/material.dart';

var themeData = ThemeData(
  fontFamily: 'Pretendard',
  scaffoldBackgroundColor: Color.fromRGBO(42, 43, 46, 1),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.3)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid,color:Color.fromRGBO(255, 255, 255, 0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style:BorderStyle.solid,color:Color.fromRGBO(255, 255, 255, 0.3)),
    )
  ),
  appBarTheme: AppBarTheme(
    toolbarHeight: 60,
    backgroundColor: Color.fromRGBO(42, 43, 46, 1),
    titleTextStyle: TextStyle(
      color: Color.fromRGBO(0, 201, 184, 1),
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    elevation: 1,
    shape: Border(
      bottom:BorderSide(
        color:Color.fromRGBO(255, 255, 255, 0.3),
        width:1,
      )
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(42, 43, 46, 1),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(0, 201, 184, 1),

    ),
  )
);