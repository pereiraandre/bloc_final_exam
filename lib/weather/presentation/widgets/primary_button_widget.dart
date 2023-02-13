import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {

  final String text;
  final Function()? onPressed;

  const PrimaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {

    return Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: MaterialButton(
            disabledColor: Colors.red,
            onPressed: onPressed,
            height: 54.0,
            minWidth: 250.0,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            )));
  }
}
