import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.hintText, this.maxlines =1});

  final TextEditingController controller;
  final String hintText;
  final int  maxlines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
