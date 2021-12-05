import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    this.icon,
    this.hintText,
    @required this.controller,
    this.textDirection,
    this.inputType,
    this.isPassword = false, this.initialValue,
  });
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextDirection textDirection;
  final TextInputType inputType;
  final bool isPassword;
  final initialValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffc8c8c8)),
          color: Color(0xfffcfcfc)),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: isPassword ? true : false,
        controller: controller,
        style: TextStyle(
          fontFamily: 'roboto'
        ),
        keyboardType: inputType,
        textDirection: textDirection,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(
              icon,
              color: Color(0xffA1A1A19E),
            ),
            onPressed: () {},
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xffA1A1A19E)),
          contentPadding: EdgeInsets.all(10),
          hintTextDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
