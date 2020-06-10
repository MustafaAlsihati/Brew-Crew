import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding:
      EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: const Color(0xFFD8D8D8),
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: const Color(0xCC8D6E63),
      width: 2.0,
    ),
  ),
);

InputDecoration brewNameTextInputDecoration(String msg) {
  return InputDecoration(
    hintText: '$msg',
    fillColor: Colors.white,
    filled: true,
    contentPadding:
        EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xFFD8D8D8),
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xCC8D6E63),
        width: 2.0,
      ),
    ),
  );
}
