import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  TextFieldWidget({super.key, required this.controller, required this.hintText});

  TextEditingController controller;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64.0, right: 64.0),
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
