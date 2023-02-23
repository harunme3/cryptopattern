// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ToastData {
  static showToast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    ));
  }

  static showToastError(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.white,
              fontSize: 14.0,
            ),
      ),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 5),
    ));
  }
}
