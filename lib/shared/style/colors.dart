import 'package:flutter/material.dart';

import '../network/local/cache_helper.dart';

const defultColor=Colors.deepOrange;
const grayColor=Color(0xFF58595B);
const whiteColor=Colors.white;
const blackColor=Color(0xFF33739);
const blakColor=Colors.black;
const  mshmshColor=Color(0xFFFFDEBD);
bool? isDark = CacheHelper.getData(key:'isDark');

Color colorD() {
  if (isDark == true) {
   return grayColor;

  }
  else return mshmshColor;
}
dynamic colorBlackOrMshmsh() {
  if (isDark == true) {
    return Colors.black;

  }
  else return mshmshColor;
}
dynamic colorBlackOrWhite() {
  if (isDark == true) {
    return Colors.black;

  }
  else return Colors.white;
}
dynamic colorOrange() {
  if (isDark == true) {
    return blakColor;

  }
  else return defultColor;
}
dynamic colorArrow() {
  if (isDark == true) {
    return mshmshColor;

  }
  else return defultColor;
}
dynamic deepOrMsh() {
  if (isDark == true) {
    return mshmshColor;

  }
  else return defultColor;
}
