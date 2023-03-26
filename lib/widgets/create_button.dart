import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final Color color, textColor;
  final String text;
  final VoidCallback action;

  const CreateButton({
    super.key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.action,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //Puede ser InkWell también
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: color,
          // boxShadow: const <BoxShadow>[
          //   BoxShadow(
          //       color: Colors.white54,
          //       blurRadius: 10.0,
          //       spreadRadius: 1.0,
          //       offset: Offset(0, 0)),
          // ]
        ),
        margin: const EdgeInsets.all(7),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }
}
