import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(
    String hintText, String labelText, IconData iconType) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.black26),
    labelText: labelText,
    suffixIcon: Icon(
      iconType,
      color: Colors.indigo,
    ),
    labelStyle: TextStyle(
      color: Colors.indigoAccent,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.indigo[300], width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}