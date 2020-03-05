import 'package:flutter/material.dart';

class Inputbox extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final String initValue;
  final TextInputType keyboardType;
  final Color color;
  final bool isPassword;
  final TextEditingController controller;

  Inputbox({
    Key key,
    this.hintText,
    this.focusNode,
    this.nextFocusNode,
    this.initValue,
    this.color,
    this.keyboardType,
    this.isPassword,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(widget.color ?? Color(0xFF566479) );
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: color ?? Color(0xFF1D283A),
            borderRadius: BorderRadius.circular(5),
          ),
          height: MediaQuery.of(context).size.height * 0.067,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            maxLines: 1,
            style: TextStyle(
              color: Color(0xFF566479),
            ),
            initialValue: initValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(0xFF566479),
                fontWeight: FontWeight.bold,
              ),
              hintText: hintText,
              // text
            ),
            textInputAction: nextFocusNode != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: (value) {
              if (nextFocusNode != null)
                FocusScope.of(context).requestFocus(nextFocusNode);
            },
            obscureText: isPassword ?? false,
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}
