import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomReadOnlyField extends StatelessWidget {
  const CustomReadOnlyField({
    Key key,
    this.icon,
    this.hintText,
    @required this.controller,
    this.textDirection,
    this.inputType,
    this.isPassword,
  });
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextDirection textDirection;
  final TextInputType inputType;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26),
          color: Color(0xfffcfcfc)),
      child: TextFormField(
        readOnly: true,
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),
        initialValue: hintText,
        controller: controller,
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
          contentPadding: EdgeInsets.all(10),
          hintTextDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
