import 'package:flutter/material.dart';

const K_login_page_color = 0xff1d475f;
const K_login_app_title_color = 0xff4fe3c3;
const K_login_input_textstyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.w300,
  letterSpacing: .5,
);

const K_username_field = InputDecoration(
  contentPadding: EdgeInsets.all(18),
  focusColor: Colors.pinkAccent,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(K_login_app_title_color))),
  hintText: 'username',
  hintStyle: K_login_input_textstyle,
  border: null,
  prefixIcon: Icon(
    Icons.person,
    color: Colors.white,
  ),
);

const K_password_field = InputDecoration(
  contentPadding: EdgeInsets.all(18),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(K_login_app_title_color))),
  hintText: 'password',
  hintStyle: K_login_input_textstyle,
  border: null,
  prefixIcon: Icon(
    Icons.lock,
    color: Colors.white,
  ),
);

const eng_vars = {
  "login_title_1": "kisaan",
  "login_title_2": "Card",
  "login_field_1": "username",
  "login_field_2": "password",
};

const hin_vars = {
  "login_title_1": "किसान",
  "login_title_2": "कार्ड",
  "login_field_1": "उपयोगकर्ता",
  "login_field_2": "पासवर्ड",
};
