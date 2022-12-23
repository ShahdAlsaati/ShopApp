
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme=ThemeData(
  splashColor:whiteColor,

  dialogBackgroundColor:Colors.black,

  //primarySwatch: mshmshColor,
    backgroundColor:grayColor,
  iconTheme: IconThemeData(color:mshmshColor ),

  scaffoldBackgroundColor: grayColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: mshmshColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData (
      color: mshmshColor,
    ),
    backwardsCompatibility:false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: grayColor,
      statusBarIconBrightness: Brightness.light,

    ),
    backgroundColor: grayColor,
    elevation: 0,
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor:  Color(0xFF33739),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20,

  ),


  textTheme: TextTheme(
    bodyText2:TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w800,
      color:Colors.black,
    ) ,

    headline5:TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color:mshmshColor,
    ) ,
    bodyText1:TextStyle(
      fontSize: 18,
      fontWeight:FontWeight.w600 ,
      color: mshmshColor,
    ),
    caption:TextStyle(
      fontSize: 12,
      color: Colors.white,
    ),
    overline: TextStyle(
      fontSize: 12,
      height: 1.3,
      color: Colors.blueGrey,
        decoration: TextDecoration.lineThrough,
    ),
      button:TextStyle(
        fontSize: 14,
        height: 1.3,
        color: Colors.white
      )
  ),

  fixTextFieldOutlineLabel:true,

);
ThemeData lightTheme=ThemeData(
  splashColor:whiteColor,
  dialogBackgroundColor:defultColor,
  backgroundColor:mshmshColor,
 scaffoldBackgroundColor: mshmshColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: defultColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData (
      color: defultColor,
    ),
    backwardsCompatibility:false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: mshmshColor,
      statusBarIconBrightness: Brightness.dark,

    ),
    backgroundColor: mshmshColor,
    elevation: 0,
  ),

  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: mshmshColor,
    selectedItemColor:  Colors.deepOrange,
    unselectedItemColor: Colors.black,
    elevation: 20,
  ),
  textTheme: TextTheme(
    bodyText2:TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w800,
      color:Colors.white,
    ) ,
    headline5:TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Colors.black87,
    ) ,
    bodyText1:TextStyle(
      fontSize: 18,
      fontWeight:FontWeight.w600 ,
      color: Colors.black87,
    ),
    caption:TextStyle(
      fontSize: 12,
        color: Colors.black,
      ),
    overline: TextStyle(
      fontSize: 10,
      height: 1.3,
      color: Colors.blue,
      decoration: TextDecoration.lineThrough,

    ),
      button:TextStyle(
          fontSize: 14,
          height: 1.3,
          color: Colors.black
      ),

  ),
  iconTheme: IconThemeData(color:defultColor ),

);