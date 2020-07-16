import 'package:flutter/material.dart';
import 'package:kpop/static/color.dart';

class InputTextBox extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputType keyboardType;
  final Color boxColor;
  final bool obscureText;
  final TextEditingController controller;

  const InputTextBox({
    Key key,
    this.hintText,
    this.focusNode,
    this.nextFocusNode,
    this.keyboardType,
    this.boxColor,
    this.obscureText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: MediaQuery.of(context).size.height * 0.067,
      decoration: BoxDecoration(
        color: boxColor ?? CustomColor.boxColor,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(0xFF566479),
            fontWeight: FontWeight.bold,
          ),
          hintText: hintText,
        ),
        maxLines: 1,
        textInputAction:
            nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (String str) =>
            FocusScope.of(context).requestFocus(nextFocusNode),
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
      ),
    );
  }
}
