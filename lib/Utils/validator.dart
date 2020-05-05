import 'package:flutter/material.dart';


class Validators {
  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String checkEmail(BuildContext context, String email) {
    if (email == null) {
      return 'Vui lòng nhập email';
    } else if (!_emailRegex.hasMatch(email)) {
      return "Email không hợp lệ";
    } else {
      return null;
    }
  }

}
