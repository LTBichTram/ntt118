import 'package:flutter/material.dart';
import 'package:nt118/constants.dart';

InputDecoration buildInputDecoration(String label){
  return InputDecoration(
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    errorStyle: TextStyle(color: Colors.black26, fontSize: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.5,
      )
    ),
    labelText: label,
  );
}