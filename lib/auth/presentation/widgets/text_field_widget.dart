import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFieldWidget(String hintText, Function(String) onChanged, Icon? suffixIcon, bool obscureText, TextEditingController controller) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.white),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      style: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: const EdgeInsets.only(left: 30, top: 40),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
