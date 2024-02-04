import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller,required this.obscureText, required this.hintText, this.maxlines =1});

  final TextEditingController controller;
  final String hintText;
  final int  maxlines;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
      maxLines: maxlines,
    );
  }
}
