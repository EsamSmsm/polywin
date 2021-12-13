import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    Key key,
    @required this.text,
    this.isRequired = false,
  }) : super(key: key);

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          text,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 10,
        ),
        isRequired
            ? Text(
                '*',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              )
            : SizedBox()
      ],
    );
  }
}
