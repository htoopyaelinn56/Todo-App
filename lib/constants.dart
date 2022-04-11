import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Color bgColor = Color(0xff0A0E21);
Color cardColor = Colors.indigo.shade900;
const Color componentColor = Colors.pinkAccent;

void showToast(String s) {
  Fluttertoast.showToast(
      msg: s,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
